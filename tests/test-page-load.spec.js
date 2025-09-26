import { test, expect } from '@playwright/test';

test('Homepage loads and visitor data appears (Hugo Console Theme)', async ({ page }) => {

  await page.goto('https://www.trinityklein.dev/posts.html', { waitUntil: 'networkidle' });
  await page.goto('https://www.trinityklein.dev/projects.html', { waitUntil: 'networkidle' });
  await page.goto('https://www.trinityklein.dev/resume.html', { waitUntil: 'networkidle' });
  await page.goto('https://www.trinityklein.dev/ping.html', { waitUntil: 'networkidle' });

  const title = await page.title();
  console.log('trinity-klein/', title);
  expect(title.length).toBeLessThanOrEqual(14);

  /* Check that index.html contents load as expected */
  await page.goto('https://www.trinityklein.dev/', { waitUntil: 'networkidle' });
  await expect(page.getByRole('heading', { name: /About Me/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /What I've Been Writing/i })).toBeVisible();

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