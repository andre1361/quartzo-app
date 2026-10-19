#!/bin/bash
# Instala (ou atualiza) o Quartzo neste Mac com a última versão publicada.
# Uso: curl -fsSL https://raw.githubusercontent.com/andre1361/quartzo-app/main/instalar.sh | bash
set -euo pipefail
REPO=andre1361/quartzo-app

if [ "$(uname -m)" != "arm64" ]; then
  echo "O Quartzo precisa de um Mac com Apple Silicon (M1 ou mais novo)."; exit 1
fi
if [ "$(sw_vers -productVersion | cut -d. -f1)" -lt 14 ]; then
  echo "O Quartzo precisa do macOS 14 (Sonoma) ou mais novo."; exit 1
fi

echo "› Procurando a última versão…"
TAG=$(curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$REPO/releases/latest" | sed 's#.*/tag/##')
VERSION=${TAG#v}
if [ -z "$VERSION" ] || [ "$VERSION" = "$TAG" ]; then
  echo "Não encontrei a versão publicada em github.com/$REPO."; exit 1
fi

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
BASE="https://github.com/$REPO/releases/download/$TAG"
echo "› Baixando o Quartzo $VERSION…"
curl -fSL --progress-bar -o "$TMP/Quartzo-$VERSION.zip" "$BASE/Quartzo-$VERSION.zip"
curl -fsSL -o "$TMP/Quartzo-$VERSION.zip.sha256" "$BASE/Quartzo-$VERSION.zip.sha256"

echo "› Conferindo o arquivo e a assinatura…"
if ! (cd "$TMP" && shasum -a 256 -c "Quartzo-$VERSION.zip.sha256" >/dev/null); then
  echo "O arquivo baixado não bate com o publicado. Nada foi instalado."; exit 1
fi
ditto -x -k "$TMP/Quartzo-$VERSION.zip" "$TMP/app"
if ! codesign --verify --strict "$TMP/app/Quartzo.app" 2>/dev/null; then
  echo "A assinatura do app não confere. Nada foi instalado."; exit 1
fi
# O app é assinado, mas ainda não passou pela notarização da Apple: sem a quarentena o macOS abre direto.
xattr -dr com.apple.quarantine "$TMP/app/Quartzo.app" 2>/dev/null || true

DEST=/Applications
[ -w "$DEST" ] || DEST="$HOME/Applications"
mkdir -p "$DEST"
if pgrep -x Quartzo >/dev/null; then
  echo "› Fechando o Quartzo aberto…"
  osascript -e 'tell application "Quartzo" to quit' >/dev/null 2>&1 || true
  for _ in $(seq 1 40); do pgrep -x Quartzo >/dev/null || break; sleep 0.5; done
fi
rm -rf "$DEST/Quartzo.app"
ditto "$TMP/app/Quartzo.app" "$DEST/Quartzo.app"
echo "✓ Quartzo $VERSION instalado em $DEST"

if ! command -v claude >/dev/null 2>&1 && [ ! -x "$HOME/.local/bin/claude" ]; then
  echo
  echo "Falta o Claude Code. Ao abrir, o Quartzo mostra um botão para instalar e entrar com a sua conta."
fi
open "$DEST/Quartzo.app"
