const { test, expect } = require('@playwright/test');

async function loginAsStaff(page) {
  await page.goto('login');
  await page.locator('input[name="username"]').fill('staff');
  await page.locator('input[name="password"]').fill('123456');
  await page.locator('button[type="submit"]').click();
  await expect(page).toHaveURL(/\/staff\/home$/);
}

test('护工页布局与退出确认框文案正常', async ({ page }) => {
  await loginAsStaff(page);
  await page.goto('staff/checkin');

  const bedSelect = page.locator('select[name="bedId"]');
  const bedNote = page.locator('.field-stack .field-note');

  await expect(page.getByRole('heading', { name: '入住登记' })).toBeVisible();
  await expect(bedSelect).toBeVisible();
  await expect(bedNote).toHaveText('请优先选择空闲床位，提交后系统会自动将该床位状态更新为“已入住”。');

  const selectBox = await bedSelect.boundingBox();
  const noteBox = await bedNote.boundingBox();
  expect(selectBox).not.toBeNull();
  expect(noteBox).not.toBeNull();
  expect(noteBox.y).toBeGreaterThan(selectBox.y + selectBox.height - 1);

  let dialogMessage = '';
  page.once('dialog', async (dialog) => {
    dialogMessage = dialog.message();
    await dialog.dismiss();
  });
  await page.getByRole('link', { name: '退出登录' }).click({ noWaitAfter: true });
  await expect.poll(() => dialogMessage).toBe('确认退出当前账号吗？');
});
