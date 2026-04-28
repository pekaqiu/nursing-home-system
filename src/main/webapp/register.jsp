<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>用户注册</h1>
    </div>
</div>
<div class="container">
    <div class="panel" style="max-width: 620px; margin: 24px auto 0;">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/register" method="post">
            <label>用户名</label>
            <input type="text" name="username" required>

            <label>密码</label>
            <input type="password" name="password" required>

            <label>真实姓名</label>
            <input type="text" name="realName" required>

            <label>手机号</label>
            <input type="text" name="phone" required>

            <button type="submit">完成注册</button>
        </form>
        <p>已有账号？<a href="${pageContext.request.contextPath}/login">去登录</a></p>
    </div>
</div>
</body>
</html>
