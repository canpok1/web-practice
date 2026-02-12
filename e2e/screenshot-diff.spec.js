import { test, expect } from "@playwright/test";
import { writeFileSync, mkdirSync } from "node:fs";
import { dirname } from "node:path";

const referenceUrl = process.env.REFERENCE_URL;
const devPath = process.env.DEV_PATH;
const threshold = process.env.DIFF_THRESHOLD
  ? parseFloat(process.env.DIFF_THRESHOLD)
  : undefined;

test("見本ページとの比較", async ({ page }, testInfo) => {
  const snapshotName = "reference.png";

  // 見本ページのスクリーンショットを取得
  await page.goto(referenceUrl);
  await page.waitForLoadState("networkidle");
  const referenceScreenshot = await page.screenshot({ fullPage: true });

  // スナップショットディレクトリに保存
  const snapshotPath = testInfo.snapshotPath(snapshotName);
  mkdirSync(dirname(snapshotPath), { recursive: true });
  writeFileSync(snapshotPath, referenceScreenshot);

  // Vite開発サーバーのページと比較
  await page.goto(`http://localhost:5173${devPath}`);
  await page.waitForLoadState("networkidle");

  const options = {
    fullPage: true,
    animations: "disabled",
  };
  if (threshold !== undefined) {
    options.maxDiffPixelRatio = threshold;
  }

  await expect(page).toHaveScreenshot(snapshotName, options);
});
