# 融合适老化交互设计的养老院信息管理系统设计与实现

## 项目简介

本项目是本科毕业设计级别的养老院信息管理系统，采用 JSP、Servlet、JDBC、MySQL 和 Tomcat 实现。系统只保留基础业务闭环，适合论文撰写、功能演示和毕业答辩。

## 技术栈

1. Java 8
2. JSP
3. Servlet
4. JDBC
5. MySQL 8.0
6. Tomcat 9
7. HTML
8. CSS
9. JavaScript
10. Maven

## 运行环境

1. JDK 8
2. Maven 3.8 及以上
3. MySQL 8.0
4. Tomcat 9

## 数据库初始化步骤

1. 打开 MySQL 客户端。
2. 执行 [sql/init.sql](/D:/File/Nursing%20home/sql/init.sql)。
3. 脚本会创建数据库 `nursing_home_db`、6 张核心表和基础测试数据。
4. 首次运行前需要先执行 `sql/init.sql`，执行 SQL 后再启动项目。

## 数据库连接配置位置

数据库连接配置文件在 [db.properties](/D:/File/Nursing%20home/src/main/resources/db.properties)。

默认配置如下：

```properties
jdbc.url=jdbc:mysql://localhost:3306/nursing_home_db?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true
jdbc.username=root
jdbc.password=123123
```

当前示例配置为 `root / 123123`，如本机不同，请自行修改。

## Tomcat 部署方式

1. 在项目根目录执行 `mvn clean package`，生成 `target/nursing-home-system.war`。
2. 将 WAR 包部署到 Tomcat `webapps` 目录。
3. 启动 Tomcat。
4. 访问 `http://localhost:8080/nursing-home-system/`。
5. 修改 `db.properties` 后，需要重新执行 `mvn clean package`，再重新部署 WAR。

也可以在 IDEA 中将该 Maven Web 项目直接部署到本地 Tomcat。

## 测试账号

1. 管理员：`admin` / `123456`
2. 工作人员：`staff` / `123456`
3. 普通用户：`user` / `123456`

## 核心功能说明

### 普通用户端

1. 注册
2. 登录
3. 查看养老院信息
4. 查看公告资讯
5. 提交入住申请
6. 查看我的申请记录

### 工作人员端

1. 工作人员首页
2. 老人入住登记
3. 日常护理记录管理

### 管理员端

1. 管理员首页
2. 用户信息管理
3. 老人档案管理
4. 床位信息管理
5. 入住申请审核

## 核心业务流程

普通用户注册或登录
→ 查看养老院信息与公告资讯
→ 提交入住申请
→ 查看我的申请记录
→ 管理员审核入住申请
→ 工作人员进行老人入住登记
→ 工作人员新增护理记录

## 页面截图建议

论文截图建议优先选择以下页面：

1. 首页、登录页、注册页
2. 普通用户首页、公告列表页、入住申请页、我的申请记录页
3. 管理员首页、入住申请审核页、床位管理页、老人档案管理页
4. 工作人员首页、入住登记页、护理记录管理页

截图前建议先准备一条入住申请、一条已审核申请、一条老人档案和一条护理记录，保证页面信息完整、观感更适合论文展示。

## 自动截图说明

如需批量生成论文截图，可先启动本地 Tomcat 并确认系统地址 `http://localhost:8080/nursing-home-system/` 可正常访问，然后在项目根目录执行：

```bash
npm install
npx playwright install chromium
npx playwright test
```

截图文件会输出到 `docs/screenshots/`，详细说明见 [docs/截图生成说明.md](/D:/File/Nursing%20home/docs/%E6%88%AA%E5%9B%BE%E7%94%9F%E6%88%90%E8%AF%B4%E6%98%8E.md)。

说明：

1. GitHub 仓库不包含 `target/` 构建产物。
2. GitHub 仓库不包含 `node_modules/` 依赖目录。
3. GitHub 仓库不包含 `docs/screenshots/` 截图目录。
4. 下载项目后，需要先执行 `mvn clean package` 再部署到 Tomcat。
5. 如需论文截图，请在本地重新执行 `npx playwright test` 生成。

## 常见运行问题

1. 页面显示数据库连接失败：
   请检查 `db.properties` 中的数据库地址、用户名、密码是否正确，并确认 MySQL 已启动，且已先执行 `sql/init.sql` 创建 `nursing_home_db`。

2. 登录成功后页面报错：
   请确认已经先执行 `sql/init.sql`，且 3 个测试账号已经成功导入。

3. Tomcat 启动后访问 404：
   请确认部署的上下文路径是否为 `nursing-home-system`，以及项目是否成功打成 WAR 包。

4. Maven 下载依赖失败：
   请检查本机网络和 Maven 仓库配置，确保能下载 `mysql-connector-j`。

## 本地运行检查步骤

1. 执行 [sql/init.sql](/D:/File/Nursing%20home/sql/init.sql)，确认数据库 `nursing_home_db`、6 张核心表、3 个测试账号、公告和床位初始数据已创建成功。
2. 修改 [db.properties](/D:/File/Nursing%20home/src/main/resources/db.properties)，确保 `jdbc.username` 和 `jdbc.password` 与本机 MySQL 账号一致。
   当前示例为 `root / 123123`。
3. 在项目根目录执行 `mvn clean package`，确认成功生成 `target/nursing-home-system.war`。
4. 将 WAR 包部署到 Tomcat 的 `webapps` 目录并启动 Tomcat。
5. 浏览器访问 `http://localhost:8080/nursing-home-system/`。
6. 分别使用 `admin / 123456`、`staff / 123456`、`user / 123456` 登录，确认能进入管理员首页、工作人员首页和普通用户首页。
7. 按核心业务闭环检查：
   普通用户提交入住申请。
   管理员审核申请并填写审核备注。
   工作人员完成入住登记并分配床位。
   工作人员新增护理记录并查看记录列表。
