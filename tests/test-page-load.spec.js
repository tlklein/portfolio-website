import { test, expect } from '@playwright/test';

test('Homepage loads and visitor data appears (Hugo Console Theme)', async ({ page }) => {

  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/posts.html', { waitUntil: 'networkidle' });
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/projects.html', { waitUntil: 'networkidle' });
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/resume.html', { waitUntil: 'networkidle' });
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/ping.html', { waitUntil: 'networkidle' });

  const title = await page.title();
  console.log('trinity-klein/', title);
  expect(title.length).toBeLessThanOrEqual(14);

  await expect(page.getByRole('heading', { name: /About/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Education/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Relevant Experience/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Technical Skills & Projects/i })).toBeVisible();

  /* Check that index.html contents, mostly visitor api, load as expected */
  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/', { waitUntil: 'networkidle' });
  await expect(page.getByRole('heading', { name: /About/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /If you have any questions or inquiries for me, please feel to reach out!/i })).toBeVisible();
  await expect(page.getByRole('heading', { name: /Latest Blogs/i })).toBeVisible();

  await expect(page.locator('#unique_visitors')).not.toHaveText('Loading...', { timeout: 10000 });
  await expect(page.locator('#total_visits')).not.toHaveText('Loading...', { timeout: 10000 });

  await expect(page.locator('#unique_visitors')).toBeVisible();
  await expect(page.locator('#total_visits')).toBeVisible();

  const unique = await page.locator('#unique_visitors').innerText();
  const total = await page.locator('#total_visits').innerText();

  console.log('Unique visitors:', unique);
  console.log('Total visitors:', total);

});