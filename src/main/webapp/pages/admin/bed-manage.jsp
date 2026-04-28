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
    <title>床位信息管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>床位信息管理</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/elderly">老人档案管理</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel">
        <h2>新增床位</h2>
        <form action="${pageContext.request.contextPath}/admin/beds" method="post">
            <input type="hidden" name="action" value="add">
            <label>房间号</label>
            <input type="text" name="roomNo" required>

            <label>床位号</label>
            <input type="text" name="bedNo" required>

            <label>床位类型</label>
            <input type="text" name="bedType" required>

            <label>状态</label>
            <select name="status" required>
                <option value="空闲">空闲</option>
                <option value="已入住">已入住</option>
            </select>

            <label>备注</label>
            <textarea name="remark"></textarea>

            <button type="submit">保存床位</button>
        </form>
    </div>

    <div class="table-panel">
        <h2>床位列表</h2>
        <table>
            <tr>
                <th>房间号</th>
                <th>床位号</th>
                <th>类型</th>
                <th>状态</th>
                <th>备注</th>
                <th>状态调整</th>
            </tr>
            <% if (bedList != null) {
                for (BedInfo bed : bedList) { %>
            <tr>
                <td><%= bed.getRoomNo() %></td>
                <td><%= bed.getBedNo() %></td>
                <td><%= bed.getBedType() %></td>
                <td><%= bed.getStatus() %></td>
                <td><%= bed.getRemark() == null ? "" : bed.getRemark() %></td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/beds" method="post">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="id" value="<%= bed.getId() %>">
                        <select name="status">
                            <option value="空闲">空闲</option>
                            <option value="已入住">已入住</option>
                        </select>
                        <button type="submit">更新</button>
                    </form>
                </td>
            </tr>
            <% }} %>
        </table>
    </div>
</div>
</body>
</html>
