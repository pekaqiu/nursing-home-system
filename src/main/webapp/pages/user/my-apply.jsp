<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.CheckinApply" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<CheckinApply> applyList = (List<CheckinApply>) request.getAttribute("applyList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>我的申请记录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>我的申请记录</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/user/home">普通用户首页</a>
            <a href="${pageContext.request.contextPath}/user/apply">继续申请</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>申请状态</h2>
        <div class="section-tip">
            <strong>记录说明：</strong>本页面只显示当前登录账号提交的入住申请，状态分为“待审核”“已通过”“已拒绝”三种，可用于查看申请办理进度。
        </div>
        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message success">申请已提交，请等待管理员审核。</div>
        <% } %>
        <table>
            <tr>
                <th>老人姓名</th>
                <th>年龄</th>
                <th>联系电话</th>
                <th>审核状态</th>
                <th>审核备注</th>
                <th>申请时间</th>
            </tr>
            <% if (applyList != null && !applyList.isEmpty()) {
                for (CheckinApply apply : applyList) { %>
            <tr>
                <td><%= apply.getElderlyName() %></td>
                <td><%= apply.getElderlyAge() %></td>
                <td><%= apply.getContactPhone() %></td>
                <td>
                    <span class="status-badge <%= "已通过".equals(apply.getAuditStatus()) ? "status-approved" : ("已拒绝".equals(apply.getAuditStatus()) ? "status-rejected" : "status-waiting") %>">
                        <%= apply.getAuditStatus() %>
                    </span>
                </td>
                <td><%= apply.getAuditRemark() == null ? "暂无" : apply.getAuditRemark() %></td>
                <td><%= apply.getCreateTime() %></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="6" class="empty-state">当前账号暂无入住申请记录，您可以先填写入住申请信息。</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
