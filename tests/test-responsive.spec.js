const { test, expect, devices } = require('@playwright/test');

test.use({ ...devices['iPhone 13'] });

test('Mobile layout loads correctly', async ({ page }) => {
  await page.goto('https://www.trinityklein.dev/', { waitUntil: 'networkidle' });

  await expect(page.locator('nav')).toBeVisible(); 
});
