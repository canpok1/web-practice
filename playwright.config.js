import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  expect: {
    toHaveScreenshot: {
      animations: "disabled",
    },
  },
  projects: [
    {
      name: "desktop",
      use: { viewport: { width: 1280, height: 720 } },
    },
    {
      name: "tablet",
      use: { viewport: { width: 768, height: 1024 } },
    },
    {
      name: "mobile",
      use: { viewport: { width: 375, height: 667 } },
    },
  ],
});
