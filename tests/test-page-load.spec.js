import { test, expect } from '@playwright/test';

test('Homepage loads and visitor data appears', async ({ page }) => {

  await page.goto('https://www.trinityklein.dev/', { waitUntil: 'networkidle' });

  const title = await page.title();
  console.log('Trinity Klein - Cloud Developer', title);
  expect(title.length).toBeLessThanOrEqual(40);

  /* Check that index.html contents load as expected */
  await page.goto('https://www.trinityklein.dev/', { waitUntil: 'networkidle' });
  await expect(page.getByRole('heading', { name: /About Me/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Experience/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Education/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Projects/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Volunteer/i })).toBeVisible();

  /* Check that visitor counter loads as expected*/
  await expect(page.locator('#unique_visitors')).not.toHaveText('Loading...', { timeout: 10000 });
  await expect(page.locator('#total_visits')).not.toHaveText('Loading...', { timeout: 10000 });

  await expect(page.locator('#unique_visitors')).toBeVisible();
  await expect(page.locator('#total_visits')).toBeVisible();

  const unique = await page.locator('#unique_visitors').innerText();
  const total = await page.locator('#total_visits').innerText();

  console.log('Unique visitors:', unique);
  console.log('Total visitors:', total);

});