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
    <title>老人档案查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>老人档案查看</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/beds">床位状态查看</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>老人档案列表</h2>
        <div class="section-tip">
            <strong>说明：</strong>老人档案由护工在入住登记时生成，管理员仅查看档案内容，不执行新增或修改操作。
        </div>
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
