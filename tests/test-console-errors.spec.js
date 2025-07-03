const { test, expect } = require('@playwright/test');

test('No major JavaScript errors in the console', async ({ page }) => {
  const errors = [];

  page.on('pageerror', error => errors.push(error.message));

  await page.goto('https://d2d06xlq6t9xmp.cloudfront.net/');

  expect(errors).toEqual([]);
});
