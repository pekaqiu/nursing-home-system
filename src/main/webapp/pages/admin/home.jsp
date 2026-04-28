<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理员首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>管理员首页</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">首页</a>
            <a href="${pageContext.request.contextPath}/admin/users">用户管理</a>
            <a href="${pageContext.request.contextPath}/admin/elderly">老人档案管理</a>
            <a href="${pageContext.request.contextPath}/admin/beds">床位信息管理</a>
            <a href="${pageContext.request.contextPath}/admin/apply-audit">入住申请审核</a>
            <a href="${pageContext.request.contextPath}/logout" onclick="return confirmLogout();">退出登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="hero">
        <h2>后台管理概览</h2>
        <p>管理员可在本页面快速查看系统中的用户、老人档案、床位和入住申请数量，并继续进入用户管理、床位管理和入住申请审核页面。</p>
        <div class="summary-strip">
            <div class="summary-item">
                <strong>系统用户数量</strong>
                <span><%= request.getAttribute("userCount") %></span>
            </div>
            <div class="summary-item">
                <strong>老人档案数量</strong>
                <span><%= request.getAttribute("elderlyCount") %></span>
            </div>
            <div class="summary-item">
                <strong>床位总数</strong>
                <span><%= request.getAttribute("bedCount") %></span>
            </div>
            <div class="summary-item">
                <strong>入住申请数量</strong>
                <span><%= request.getAttribute("applyCount") %></span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
