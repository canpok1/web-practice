#!/bin/bash
set -euo pipefail

usage() {
  echo "使い方: $0 <見本URL> <Viteパス> [差分閾値]"
  echo ""
  echo "引数:"
  echo "  見本URL     見本WebページのURL"
  echo "  Viteパス    Vite開発サーバー上のパス（例: /about）"
  echo "  差分閾値    差分の許容閾値（0〜1、例: 0.05）（省略可）"
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

REFERENCE_URL="$1"
DEV_PATH="$2"
DIFF_THRESHOLD="${3:-}"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$PROJECT_DIR"

VITE_PID=""

cleanup() {
  if [ -n "$VITE_PID" ]; then
    echo "Vite開発サーバーを終了します..."
    kill "$VITE_PID" 2>/dev/null || true
    wait "$VITE_PID" 2>/dev/null || true
    echo "Vite開発サーバーを終了しました"
  fi
}
trap cleanup EXIT

# Vite開発サーバーを起動
echo "Vite開発サーバーを起動します..."
npx vite --host 0.0.0.0 &
VITE_PID=$!

# サーバー起動待機
echo "Vite開発サーバーの起動を待機中..."
for i in $(seq 1 30); do
  if curl -s http://localhost:5173 > /dev/null 2>&1; then
    echo "Vite開発サーバーが起動しました"
    break
  fi
  if [ "$i" -eq 30 ]; then
    echo "エラー: Vite開発サーバーの起動がタイムアウトしました" >&2
    exit 1
  fi
  sleep 1
done

# Playwrightテスト実行
echo "スクリーンショット比較を開始します..."
REFERENCE_URL="$REFERENCE_URL" \
DEV_PATH="$DEV_PATH" \
DIFF_THRESHOLD="$DIFF_THRESHOLD" \
  npx playwright test

echo "スクリーンショット比較が完了しました"
