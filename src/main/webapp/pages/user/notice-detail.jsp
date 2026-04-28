<%@ page import="com.nursinghome.entity.Notice" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Notice notice = (Notice) request.getAttribute("notice");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>公告详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>公告详情</h1>
    </div>
</div>
<div class="container">
    <div class="panel">
        <h2><%= notice == null ? "未找到公告" : notice.getTitle() %></h2>
        <p>发布时间：<%= notice == null ? "" : notice.getPublishTime() %></p>
        <p><%= notice == null ? "请返回公告列表重新查看。" : notice.getContent() %></p>
        <p><a href="${pageContext.request.contextPath}/notice">返回公告列表</a></p>
    </div>
</div>
</body>
</html>
