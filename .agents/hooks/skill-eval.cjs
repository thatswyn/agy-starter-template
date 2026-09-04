#!/usr/bin/env node
/**
 * Motor de evaluación de skills para Antigravity — hook PreInvocation.
 *
 * Lee el contexto o prompt, lo puntúa contra las reglas de skill-rules.json y,
 * si alguna skill supera el umbral de confianza, la sugiere.
 *
 * Compatible con:
 * 1. Protocolo de hooks de Antigravity (evento PreInvocation -> stdout JSON con injectSteps).
 * 2. Invocación manual / CLI con `{"prompt": "..."}` o texto libre.
 *
 * Sin dependencias externas.
 */

const fs = require('fs');
const path = require('path');

const RULES_PATH = path.join(__dirname, 'skill-rules.json');

const DEFAULT_CONFIG = { minScore: 4, maxSkills: 3, showReasons: true };
const DEFAULT_WEIGHTS = {
  keyword: 2,
  keywordPattern: 3,
  intentPattern: 4,
  pathPattern: 4,
  directoryMatch: 5,
};

const REGEX_SPECIALS = '.+^${}()|[]\\';

function globToRegExp(glob) {
  let out = '';
  for (let i = 0; i < glob.length; i++) {
    const c = glob[i];
    if (c === '*') {
      if (glob[i + 1] === '*') {
        i++;
        if (glob[i + 1] === '/') {
          i++;
          out += '(?:.*/)?';
        } else {
          out += '.*';
        }
      } else {
        out += '[^/]*';
      }
    } else if (c === '?') {
      out += '.';
    } else if (REGEX_SPECIALS.includes(c)) {
      out += '\\' + c;
    } else {
      out += c;
    }
  }
  try {
    return new RegExp('^' + out + '$', 'i');
  } catch {
    return null;
  }
}

function test(pattern, text) {
  try {
    return new RegExp(pattern, 'i').test(text);
  } catch {
    return false;
  }
}

function extractPaths(prompt) {
  const found = new Set();
  const patterns = [
    /(?:^|[\s"'`(])([\w@.\-]+(?:\/[\w.\-]+)+\.[a-z0-9]{1,6})\b/gi,
    /(?:^|[\s"'`(])([\w.\-]+\.[a-z0-9]{1,6})\b/gi,
    /(?:^|[\s"'`(])((?:\.?[\w-]+\/){1,}[\w-]*)/g,
  ];
  for (const re of patterns) {
    let m;
    while ((m = re.exec(prompt)) !== null) found.add(m[1]);
  }
  return [...found];
}

function scoreSkill(name, skill, prompt, paths, weights, dirMap) {
  const lower = prompt.toLowerCase();
  const triggers = skill.triggers || {};
  let score = 0;
  const reasons = [];

  for (const ex of skill.excludePatterns || []) {
    if (test(ex, lower)) return null;
  }

  for (const kw of triggers.keywords || []) {
    if (lower.includes(kw.toLowerCase())) {
      score += weights.keyword;
      reasons.push('palabra "' + kw + '"');
      break;
    }
  }
  for (const p of triggers.keywordPatterns || []) {
    if (test(p, prompt)) {
      score += weights.keywordPattern;
      reasons.push('patrón de vocabulario');
      break;
    }
  }
  for (const p of triggers.intentPatterns || []) {
    if (test(p, prompt)) {
      score += weights.intentPattern;
      reasons.push('intención detectada');
      break;
    }
  }
  for (const glob of triggers.pathPatterns || []) {
    const re = globToRegExp(glob);
    if (re && paths.some((f) => re.test(f))) {
      score += weights.pathPattern;
      reasons.push('ruta tipo ' + glob);
      break;
    }
  }
  for (const [dir, mapped] of Object.entries(dirMap)) {
    if (mapped === name && paths.some((f) => f.startsWith(dir))) {
      score += weights.directoryMatch;
      reasons.push('directorio ' + dir);
      break;
    }
  }

  return score > 0 ? { name, score, reasons, priority: skill.priority || 5 } : null;
}

function evaluate(prompt) {
  let rules;
  try {
    rules = JSON.parse(fs.readFileSync(RULES_PATH, 'utf8'));
  } catch {
    return '';
  }

  const config = Object.assign({}, DEFAULT_CONFIG, rules.config || {});
  const weights = Object.assign({}, DEFAULT_WEIGHTS, rules.weights || {});
  const dirMap = rules.directoryMappings || {};
  const skills = rules.skills || {};
  const paths = extractPaths(prompt);

  const matches = Object.entries(skills)
    .map(([name, skill]) => scoreSkill(name, skill, prompt, paths, weights, dirMap))
    .filter((m) => m && m.score >= config.minScore)
    .sort((a, b) => b.score - a.score || b.priority - a.priority)
    .slice(0, config.maxSkills);

  if (matches.length === 0) return '';

  const lines = [
    'Skills del proyecto que parecen relevantes para esta petición:',
    '',
  ];
  for (const m of matches) {
    const why =
      config.showReasons && m.reasons.length
        ? ' — coincide por: ' + m.reasons.slice(0, 3).join(', ')
        : '';
    const desc = skills[m.name].description ? ' (' + skills[m.name].description + ')' : '';
    lines.push('- ' + m.name + desc + why);
  }
  lines.push(
    '',
    'Evalúa si aplican de verdad antes de implementar. Si alguna aplica, consulta',
    'su archivo SKILL.md o invócala. Si ninguna aplica, ignora esta nota y continúa.'
  );

  return lines.join('\n');
}

let input = '';
process.stdin.setEncoding('utf8');
process.stdin.on('data', (chunk) => (input += chunk));
process.stdin.on('end', () => {
  let isHookPayload = false;
  let prompt = '';

  try {
    const parsed = JSON.parse(input);
    if (parsed.prompt) {
      prompt = parsed.prompt;
    } else if (parsed.transcriptPath || parsed.invocationNum !== undefined) {
      isHookPayload = true;
      if (parsed.transcriptPath && fs.existsSync(parsed.transcriptPath)) {
        try {
          const lines = fs.readFileSync(parsed.transcriptPath, 'utf8').trim().split('\n');
          for (let i = lines.length - 1; i >= 0; i--) {
            const step = JSON.parse(lines[i]);
            if (step.type === 'USER_INPUT' && step.content) {
              prompt = step.content;
              break;
            }
          }
        } catch {}
      }
    }
  } catch {
    prompt = input;
  }

  const result = prompt.trim() ? evaluate(prompt) : '';

  if (isHookPayload) {
    if (result) {
      process.stdout.write(JSON.stringify({
        injectSteps: [{ ephemeralMessage: result }]
      }) + '\n');
    } else {
      process.stdout.write('{}\n');
    }
  } else {
    if (result) {
      process.stdout.write(result + '\n');
    }
  }
  process.exit(0);
});
