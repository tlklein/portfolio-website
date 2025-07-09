const { test, expect, devices } = require('@playwright/test');

test.use({ ...devices['iPhone 13'] });

test('Mobile layout loads correctly', async ({ page }) => {
  await page.goto('http://localhost:1313/');

  await expect(page.locator('nav')).toBeVisible(); // or hamburger menu
  await expect(page.locator('#unique_visitors')).toBeVisible();
});