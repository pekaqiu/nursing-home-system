<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.ElderlyProfile" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<ElderlyProfile> elderlyList = (List<ElderlyProfile>) request.getAttribute("elderlyList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>老人档案管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>老人档案管理</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/beds">床位信息管理</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>老人档案列表</h2>
        <table>
            <tr>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>联系电话</th>
                <th>家属联系人</th>
                <th>家属电话</th>
                <th>健康状况</th>
                <th>入住日期</th>
                <th>床位</th>
                <th>状态</th>
            </tr>
            <% if (elderlyList != null) {
                for (ElderlyProfile profile : elderlyList) { %>
            <tr>
                <td><%= profile.getName() %></td>
                <td><%= profile.getGender() %></td>
                <td><%= profile.getAge() %></td>
                <td><%= profile.getPhone() %></td>
                <td><%= profile.getFamilyContact() %></td>
                <td><%= profile.getFamilyPhone() %></td>
                <td><%= profile.getHealthCondition() %></td>
                <td><%= profile.getCheckinDate() %></td>
                <td><%= profile.getBedDisplay() %></td>
                <td><%= profile.getStatus() %></td>
            </tr>
            <% }} %>
        </table>
    </div>
</div>
</body>
</html>
