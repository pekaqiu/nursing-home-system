<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.SysUser" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<SysUser> userList = (List<SysUser>) request.getAttribute("userList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>用户管理</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/apply-audit">入住申请审核</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>系统用户列表</h2>
        <table>
            <tr>
                <th>编号</th>
                <th>用户名</th>
                <th>真实姓名</th>
                <th>手机号</th>
                <th>角色</th>
                <th>状态</th>
            </tr>
            <% if (userList != null) {
                for (SysUser user : userList) { %>
            <tr>
                <td><%= user.getId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getRealName() %></td>
                <td><%= user.getPhone() %></td>
                <td><%= "ADMIN".equals(user.getRole()) ? "管理员" : ("STAFF".equals(user.getRole()) ? "工作人员" : "普通用户") %></td>
                <td><%= user.getStatus() %></td>
            </tr>
            <% }} %>
        </table>
    </div>
</div>
</body>
</html>
