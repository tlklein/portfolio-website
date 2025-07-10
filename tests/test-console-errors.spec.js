const { test, expect, devices } = require('@playwright/test');

test.use({ ...devices['iPhone 13'] });

test('Mobile layout loads correctly', async ({ page }) => {
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/', { waitUntil: 'networkidle' });

  await expect(page.locator('nav')).toBeVisible(); // or hamburger menu
  await expect(page.locator('#unique_visitors')).toBeVisible();
});