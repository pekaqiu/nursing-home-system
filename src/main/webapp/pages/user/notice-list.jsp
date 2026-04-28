<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.Notice" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Notice> noticeList = (List<Notice>) request.getAttribute("noticeList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>公告资讯</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>公告资讯</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/index.jsp">首页</a>
            <a href="${pageContext.request.contextPath}/notice">公告资讯</a>
            <a href="${pageContext.request.contextPath}/login">登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>公告列表</h2>
        <table>
            <tr>
                <th>标题</th>
                <th>发布时间</th>
                <th>操作</th>
            </tr>
            <% if (noticeList != null) {
                for (Notice notice : noticeList) { %>
            <tr>
                <td><%= notice.getTitle() %></td>
                <td><%= notice.getPublishTime() %></td>
                <td><a href="${pageContext.request.contextPath}/notice?action=detail&id=<%= notice.getId() %>">查看详情</a></td>
            </tr>
            <% }} %>
        </table>
    </div>
</div>
</body>
</html>
