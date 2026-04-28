<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.Notice" %>
<%@ page import="com.nursinghome.entity.SysUser" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    SysUser loginUser = (SysUser) request.getAttribute("loginUser");
    List<Notice> noticeList = (List<Notice>) request.getAttribute("noticeList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>普通用户首页</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>普通用户首页</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/user/home">首页</a>
            <a href="${pageContext.request.contextPath}/notice">公告资讯</a>
            <a href="${pageContext.request.contextPath}/user/apply">提交入住申请</a>
            <a href="${pageContext.request.contextPath}/user/apply?action=my">我的申请记录</a>
            <a href="${pageContext.request.contextPath}/logout" onclick="return confirmLogout();">退出登录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="hero">
        <h2>欢迎您，<%= loginUser == null ? "" : loginUser.getRealName() %></h2>
        <p>本院提供生活照护、起居协助、健康观察和温馨陪伴服务。您可以先查看公告资讯，再根据需要提交入住申请。</p>
        <div class="actions">
            <a class="button-link" href="${pageContext.request.contextPath}/user/apply">填写入住申请</a>
            <a class="button-link button-secondary" href="${pageContext.request.contextPath}/user/apply?action=my">查看申请记录</a>
        </div>
    </div>

    <div class="grid-2">
        <div class="card">
            <strong>养老院信息</strong>
            <p>居住环境整洁安静，配有护理站、休息区和基础康养设施，适合老人安心居住。</p>
        </div>
        <div class="card">
            <strong>办理流程</strong>
            <p>提交入住申请后，管理员会进行审核；审核通过后，工作人员会继续完成入住登记和护理记录管理。</p>
        </div>
    </div>

    <div class="table-panel">
        <h2>最新公告</h2>
        <table>
            <tr>
                <th>标题</th>
                <th>发布时间</th>
                <th>查看</th>
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
