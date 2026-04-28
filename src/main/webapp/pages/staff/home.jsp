<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>工作人员首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>工作人员首页</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">首页</a>
            <a href="${pageContext.request.contextPath}/staff/checkin">入住登记</a>
            <a href="${pageContext.request.contextPath}/staff/care-record">护理记录管理</a>
            <a href="${pageContext.request.contextPath}/logout" onclick="return confirmLogout();">退出登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="hero">
        <h2>工作人员业务概览</h2>
        <p>工作人员可在本页面进入入住登记和护理记录管理页面，完成老人档案登记、床位分配和日常护理记录维护。</p>
        <div class="summary-strip">
            <div class="summary-item">
                <strong>已入住老人数量</strong>
                <span><%= request.getAttribute("elderlyCount") %></span>
            </div>
            <div class="summary-item">
                <strong>护理记录数量</strong>
                <span><%= request.getAttribute("careCount") %></span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
