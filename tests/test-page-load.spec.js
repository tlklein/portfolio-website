import { test, expect } from '@playwright/test';

test('Homepage loads and visitor data appears (Hugo Console Theme)', async ({ page }) => {
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/');

  const title = await page.title();
  console.log('/', title);
  expect(title.length).toBeLessThanOrEqual(1);

  await expect(page.getByRole('heading', { name: /About/i })).toBeVisible();
   await expect(page.getByRole('heading', { name: /Education/i })).toBeVisible();
    await expect(page.getByRole('heading', { name: /Relevant Experience/i })).toBeVisible();
     await expect(page.getByRole('heading', { name: /Technical Skills & Projects/i })).toBeVisible();

  await expect(page.locator('#unique_visitors')).toBeVisible();
  await expect(page.locator('#total_visits')).toBeVisible();

  const unique = await page.locator('#unique_visitors').innerText();
  const total = await page.locator('#total_visits').innerText();

  console.log(`Unique Visitors: ${unique}, Total Visits: ${total}`);
});