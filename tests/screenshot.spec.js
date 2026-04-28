const { test, expect } = require('@playwright/test');
const fs = require('fs');
const path = require('path');

const screenshotDir = path.join(__dirname, '..', 'docs', 'screenshots');

function ensureDir() {
  fs.mkdirSync(screenshotDir, { recursive: true });
}

async function shot(page, fileName) {
  await page.screenshot({
    path: path.join(screenshotDir, fileName),
    fullPage: true
  });
}

async function login(page, username, password) {
  await page.goto('login');
  await expect(page.getByRole('heading', { name: '用户登录' })).toBeVisible();
  await page.locator('input[name="username"]').fill(username);
  await page.locator('input[name="password"]').fill(password);
  await page.getByRole('button', { name: '立即登录' }).click();
}

test.beforeAll(async () => {
  ensureDir();
});

test('生成论文页面截图', async ({ browser }) => {
  const publicContext = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const publicPage = await publicContext.newPage();

  await publicPage.goto('./');
  await expect(
  publicPage.getByRole('heading', {
    name: '养老院信息管理系统',
    level: 1,
    exact: true
  })
).toBeVisible();
  await shot(publicPage, '01-首页.png');

  await publicPage.goto('login');
  await expect(publicPage.getByRole('heading', { name: '用户登录' })).toBeVisible();
  await shot(publicPage, '02-登录页.png');

  await publicPage.goto('register');
  await expect(publicPage.getByRole('heading', { name: '用户注册' })).toBeVisible();
  await shot(publicPage, '03-注册页.png');

  await publicContext.close();

  const userContext = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const userPage = await userContext.newPage();

  await login(userPage, 'user', '123456');
  await expect(userPage.getByRole('heading', { name: '普通用户首页' })).toBeVisible();
  await shot(userPage, '04-普通用户首页.png');

  await userPage.goto('notice');
  await expect(userPage.getByRole('heading', { name: '公告资讯' })).toBeVisible();
  await shot(userPage, '05-公告列表页.png');

  const detailLink = userPage.getByRole('link', { name: '查看详情' }).first();
  await expect(detailLink).toBeVisible();
  await detailLink.click();
  await expect(userPage.getByRole('heading', { name: '公告详情' })).toBeVisible();
  await shot(userPage, '06-公告详情页.png');

  await userPage.goto('user/apply');
  await expect(userPage.getByRole('heading', { name: '入住申请' })).toBeVisible();
  await shot(userPage, '07-入住申请页.png');

  await userPage.goto('user/apply?action=my');
  await expect(userPage.getByRole('heading', { name: '我的申请记录' })).toBeVisible();
  await shot(userPage, '08-我的申请记录页.png');

  await userContext.close();

  const adminContext = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const adminPage = await adminContext.newPage();

  await login(adminPage, 'admin', '123456');
  await expect(adminPage.getByRole('heading', { name: '管理员首页' })).toBeVisible();
  await shot(adminPage, '09-管理员首页.png');

  await adminPage.goto('admin/apply-audit');
  await expect(adminPage.getByRole('heading', { name: '入住申请审核' })).toBeVisible();
  await shot(adminPage, '10-入住申请审核页.png');

  await adminPage.goto('admin/users');
  await expect(adminPage.getByRole('heading', { name: '用户管理' })).toBeVisible();
  await shot(adminPage, '11-用户管理页.png');

  await adminPage.goto('admin/elderly');
  await expect(adminPage.getByRole('heading', { name: '老人档案管理' })).toBeVisible();
  await shot(adminPage, '12-老人档案管理页.png');

  await adminPage.goto('admin/beds');
  await expect(adminPage.getByRole('heading', { name: '床位信息管理' })).toBeVisible();
  await shot(adminPage, '13-床位管理页.png');

  await adminContext.close();

  const staffContext = await browser.newContext({ viewport: { width: 1440, height: 900 } });
  const staffPage = await staffContext.newPage();

  await login(staffPage, 'staff', '123456');
  await expect(staffPage.getByRole('heading', { name: '工作人员首页' })).toBeVisible();
  await shot(staffPage, '14-工作人员首页.png');

  await staffPage.goto('staff/checkin');
  await expect(staffPage.getByRole('heading', { name: '入住登记' })).toBeVisible();
  await shot(staffPage, '15-入住登记页.png');

  await staffPage.goto('staff/care-record');
  await expect(staffPage.getByRole('heading', { name: '护理记录管理' })).toBeVisible();
  await shot(staffPage, '16-护理记录管理页.png');

  await staffContext.close();
});
