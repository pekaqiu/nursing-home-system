<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>护工首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>护工首页</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">首页</a>
            <a href="${pageContext.request.contextPath}/staff/pending-checkin">待登记名单查看</a>
            <a href="${pageContext.request.contextPath}/staff/checkin">入住登记</a>
            <a href="${pageContext.request.contextPath}/staff/care-record">护理记录管理</a>
            <a href="${pageContext.request.contextPath}/staff/care-record-query">护理记录查询</a>
            <a href="${pageContext.request.contextPath}/logout" onclick="return window.confirm('\u786e\u8ba4\u9000\u51fa\u5f53\u524d\u8d26\u53f7\u5417\uff1f');">退出登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="hero">
        <h2>护工业务概览</h2>
        <p>护工负责查看待登记名单、办理入住登记、维护护理记录和查询护理记录，所有功能均围绕入住和日常照护展开，不与其他角色职责重叠。</p>
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
