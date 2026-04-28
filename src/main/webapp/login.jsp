<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>用户登录</h1>
    </div>
</div>
<div class="container">
    <div class="panel" style="max-width: 560px; margin: 24px auto 0;">
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
        <div class="message success"><%= request.getAttribute("successMessage") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/login" method="post">
            <label>用户名</label>
            <input type="text" name="username" required>

            <label>密码</label>
            <input type="password" name="password" required>

            <button type="submit">立即登录</button>
        </form>
        <p>还没有账号？<a href="${pageContext.request.contextPath}/register">去注册</a></p>
        <p><a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></p>
    </div>
</div>
</body>
</html>
