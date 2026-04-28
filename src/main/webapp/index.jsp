<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>养老院信息管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>养老院信息管理系统</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <a href="${pageContext.request.contextPath}/notice">公告资讯</a>
            <a href="${pageContext.request.contextPath}/login">登录</a>
            <a href="${pageContext.request.contextPath}/register">注册</a>
        </div>
    </div>
</div>

<div class="container">
    <div class="hero">
        <h2>融合适老化交互设计的养老院信息管理系统设计与实现</h2>
        <p>本系统面向养老院基础业务管理场景，保留用户申请入住、管理员审核、工作人员登记入住与护理记录等核心功能，页面采用大字号、清晰配色和简洁操作流程，方便老人家属和工作人员使用。</p>
        <div class="actions">
            <a class="button-link" href="${pageContext.request.contextPath}/login">进入系统</a>
            <a class="button-link button-secondary" href="${pageContext.request.contextPath}/notice">查看公告资讯</a>
        </div>
    </div>

    <div class="grid-2">
        <div class="card">
            <strong>养老院信息</strong>
            <p>提供舒适居住环境、日常生活照护、规律健康观察和温馨人文关怀，帮助老人安心生活。</p>
        </div>
        <div class="card">
            <strong>服务流程</strong>
            <p>注册登录后可提交入住申请，管理员审核通过后，工作人员进行入住登记并持续维护护理记录。</p>
        </div>
    </div>
</div>

<div class="footer">养老院信息管理系统</div>
</body>
</html>
