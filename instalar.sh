#!/usr/bin/env bash
# Instala o Kit Jarvis em ~/.claude sem sobrescrever nada que já exista.
set -euo pipefail

ORIGEM="$(cd "$(dirname "$0")" && pwd)"
DESTINO="${CLAUDE_HOME:-$HOME/.claude}"

mkdir -p "$DESTINO/memoria/fatos" "$DESTINO/regras" "$DESTINO/skills/handoff" "$DESTINO/handoffs"

# copia só o que ainda não existe (cp -n devolve erro no macOS quando pula, por isso o laço)
copiar() {
  local destino="$1"; shift
  for arquivo in "$@"; do
    [ -e "$destino/$(basename "$arquivo")" ] || cp "$arquivo" "$destino/"
  done
}

copiar "$DESTINO/memoria" "$ORIGEM/memoria/MEMORY.md" "$ORIGEM/memoria/COMO-USAR.md"
copiar "$DESTINO/memoria/fatos" "$ORIGEM"/memoria/fatos/*.md
copiar "$DESTINO/regras" "$ORIGEM/regras/sessoes-paralelas.md"
copiar "$DESTINO/skills/handoff" "$ORIGEM"/skills/handoff/*.md
copiar "$DESTINO/handoffs" "$ORIGEM/skills/handoff/MODELO.md"

if [ -e "$DESTINO/CLAUDE.md" ]; then
  cp "$ORIGEM/CLAUDE.md" "$DESTINO/CLAUDE.jarvis.md"
  echo "Você já tem um $DESTINO/CLAUDE.md. O do kit ficou em $DESTINO/CLAUDE.jarvis.md:"
  echo "junte os dois à mão (o README explica como)."
else
  cp "$ORIGEM/CLAUDE.md" "$DESTINO/CLAUDE.md"
  echo "CLAUDE.md instalado em $DESTINO/CLAUDE.md"
fi

echo "Pronto. Agora edite os campos entre <> no CLAUDE.md e no memoria/MEMORY.md."
