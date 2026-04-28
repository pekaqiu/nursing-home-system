// @ts-check
const { defineConfig } = require('@playwright/test');

module.exports = defineConfig({
  testDir: './tests',
  timeout: 60000,
  reporter: 'line',
  use: {
    baseURL: 'http://localhost:8080/nursing-home-system/',
    browserName: 'chromium',
    viewport: { width: 1440, height: 900 },
    ignoreHTTPSErrors: true,
    screenshot: 'off'
  }
});
