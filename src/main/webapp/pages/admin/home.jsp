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
            <a href="${pageContext.request.contextPath}/admin/elderly">老人档案查看</a>
            <a href="${pageContext.request.contextPath}/admin/beds">床位状态查看</a>
            <a href="${pageContext.request.contextPath}/admin/apply-audit">入住申请审核</a>
            <a href="${pageContext.request.contextPath}/logout" onclick="return window.confirm('\u786e\u8ba4\u9000\u51fa\u5f53\u524d\u8d26\u53f7\u5417\uff1f');">退出登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="hero">
        <h2>后台管理概览</h2>
        <p>管理员负责用户信息管理与入住申请审核，并可查看老人档案和床位状态，不参与老人入住登记和护理记录填写。</p>
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
