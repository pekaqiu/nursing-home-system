<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.BedInfo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<BedInfo> bedList = (List<BedInfo>) request.getAttribute("bedList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>床位状态查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>床位状态查看</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/elderly">老人档案查看</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>床位列表</h2>
        <div class="section-tip">
            <strong>说明：</strong>床位状态会在护工完成入住登记后自动更新，管理员仅查看当前床位使用情况。
        </div>
        <table>
            <tr>
                <th>房间号</th>
                <th>床位号</th>
                <th>类型</th>
                <th>状态</th>
                <th>备注</th>
            </tr>
            <% if (bedList != null) {
                for (BedInfo bed : bedList) { %>
            <tr>
                <td><%= bed.getRoomNo() %></td>
                <td><%= bed.getBedNo() %></td>
                <td><%= bed.getBedType() %></td>
                <td><%= bed.getStatus() %></td>
                <td><%= bed.getRemark() == null ? "" : bed.getRemark() %></td>
            </tr>
            <% }} %>
        </table>
    </div>
</div>
</body>
</html>
