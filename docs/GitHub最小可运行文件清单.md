# GitHub最小可运行文件清单

## 1. 必须上传的文件和目录

| 文件或目录 | 是否上传 | 作用 | 备注 |
| ----- | ---- | -- | -- |
| `pom.xml` | 是 | Maven 项目构建配置 | 用于下载依赖并打包 WAR |
| `README.md` | 是 | 项目运行说明文档 | 供下载者查看部署步骤 |
| `AGENTS.md` | 是 | 项目约束说明文档 | 便于后续继续维护 |
| `.gitignore` | 是 | Git 忽略规则配置 | 控制不上传目录和临时文件 |
| `sql/init.sql` | 是 | 数据库初始化脚本 | 创建数据库、表和演示数据 |
| `src/main/java/` | 是 | Java 后端源码 | 包含实体类、DAO、Service、Servlet、Filter |
| `src/main/resources/db.properties` | 是 | 数据库连接配置 | 下载后可按本机环境修改 |
| `src/main/webapp/` | 是 | JSP 页面和静态资源 | 系统前端展示层源码 |
| `docs/` | 是 | 项目说明文档目录 | 上传 Markdown 文档，`docs/screenshots/` 除外 |
| `package.json` | 是 | Playwright 依赖说明 | 用于安装自动截图脚本依赖 |
| `package-lock.json` | 是 | Node 依赖锁定文件 | 保证截图脚本依赖版本稳定 |
| `playwright.config.js` | 是 | Playwright 运行配置 | 定义截图测试基础配置 |
| `tests/` | 是 | 自动截图脚本目录 | 包含 `screenshot.spec.js` |

## 2. 不应上传的文件和目录

| 文件或目录 | 是否上传 | 不上传原因 | 如何重新生成 |
| ----- | ---- | ----- | ------ |
| `target/` | 否 | Maven 构建输出目录 | 执行 `mvn clean package` 重新生成 |
| `target/nursing-home-system.war` | 否 | WAR 构建产物 | 执行 `mvn clean package` 重新生成 |
| `node_modules/` | 否 | Node 依赖目录体积大且可重复安装 | 执行 `npm install` 重新生成 |
| `docs/screenshots/` | 否 | 截图属于自动生成结果，不是运行必需文件 | 执行 `npx playwright test` 重新生成 |
| `test-results/` | 否 | Playwright 测试结果目录 | 执行 `npx playwright test` 重新生成 |
| `playwright-report/` | 否 | Playwright 测试报告目录 | 执行 `npx playwright test` 重新生成 |
| `.idea/` | 否 | IDEA 本地配置目录 | 由 IDE 本地自动生成 |
| `.vscode/` | 否 | VS Code 本地配置目录 | 由编辑器本地自动生成 |
| `*.iml` | 否 | IDEA 模块文件 | 由 IDE 本地自动生成 |
| `*.class` | 否 | Java 编译产物 | 执行 `mvn clean package` 重新生成 |
| `*.log` | 否 | 运行日志文件 | 系统运行时自动生成 |

## 3. 关于截图不上传的说明

本项目不上传 `docs/screenshots/` 截图目录。截图属于 Playwright 自动生成结果，不是系统运行所必需文件。下载项目后，如果需要重新生成截图，可以先启动 MySQL 和 Tomcat，再执行 `npx playwright test`。

## 4. GitHub 下载后运行步骤

1. 安装 JDK。
2. 安装 Maven。
3. 安装 MySQL。
4. 安装 Tomcat。
5. 执行 `sql/init.sql` 初始化数据库。
6. 修改 `src/main/resources/db.properties` 中的数据库账号密码。
7. 在项目根目录执行：

```bash
mvn clean package
```

8. 将生成的：

```text
target/nursing-home-system.war
```

复制到 Tomcat 的 `webapps` 目录。

9. 启动 Tomcat。
10. 浏览器访问：

```text
http://localhost:8080/nursing-home-system/
```

11. 使用以下测试账号登录：

```text
admin / 123456
staff / 123456
user / 123456
```

## 5. 截图重新生成步骤

如果需要重新生成论文截图，在项目根目录执行：

```bash
npm install
npx playwright install chromium
npx playwright test
```

截图会重新生成到：

```text
docs/screenshots/
```

但该目录不会上传 GitHub。
