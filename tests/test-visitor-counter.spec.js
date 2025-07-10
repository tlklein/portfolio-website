const { test, expect } = require('@playwright/test');

test('Visitor counter API returns valid data and displays it', async ({ page }) => {
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/');

  // Wait for API call and DOM update
  const unique = await page.locator('#unique_visitors');
  const total = await page.locator('#total_visits');

  await expect(unique).not.toHaveText('Loading...');
  await expect(total).not.toHaveText('Loading...');

  const uniqueText = await unique.textContent();
  const totalText = await total.textContent();

  expect(Number(uniqueText)).toBeGreaterThanOrEqual(0);
  expect(Number(totalText)).toBeGreaterThanOrEqual(Number(uniqueText));
});