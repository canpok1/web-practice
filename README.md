# web-practice
Webサイト作成の練習

## スクリーンショット差分比較

見本WebページとVite開発サーバー上のページをスクリーンショットで比較し、差分を確認できます。

### 前提条件

```bash
npm install
npx playwright install --with-deps chromium
```

### 使い方

```bash
bash scripts/compare-screenshots.sh <見本URL> <Viteパス> [差分閾値]
```

#### 引数

| 引数 | 必須 | 説明 |
|---|---|---|
| 見本URL | はい | 見本WebページのURL |
| Viteパス | はい | Vite開発サーバー上のパス（例: `/about`） |
| 差分閾値 | いいえ | 差分の許容閾値（0〜1、例: `0.05` = 5%）。省略時はPlaywrightの標準値を使用 |

#### 実行例

```bash
# 基本的な使い方
bash scripts/compare-screenshots.sh https://example.com /

# 差分閾値を指定（5%まで許容）
bash scripts/compare-screenshots.sh https://example.com /about 0.05
```

#### 比較ビューポート

以下の3サイズで比較を行います:

- デスクトップ（1280x720）
- タブレット（768x1024）
- モバイル（375x667）

#### 差分画像の出力

差分がある場合、`test-results/` ディレクトリに差分画像が出力されます。
