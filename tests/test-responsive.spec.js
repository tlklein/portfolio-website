import { test, expect, devices } from '@playwright/test';

test.use({ ...devices['iPhone 13'] });

test('Mobile layout loads correctly', async ({ page }) => {
  await page.goto('https://www.trinityklein.dev/', { waitUntil: 'networkidle' });
});
