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
    <title>入住申请审核</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>入住申请审核</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/admin/home">管理员首页</a>
            <a href="${pageContext.request.contextPath}/admin/users">用户管理</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>申请审核列表</h2>
        <div class="section-tip">
            <strong>审核说明：</strong>请根据老人基本情况、健康说明和入住需求进行审核。审核完成后，普通用户可在“我的申请记录”页面查看审核结果。
        </div>
        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message success">审核结果已保存，申请状态已更新。</div>
        <% } %>
        <% if ("1".equals(request.getParameter("error"))) { %>
        <div class="message error">审核保存失败，请重新提交。</div>
        <% } %>
        <table>
            <tr>
                <th>申请人</th>
                <th>老人姓名</th>
                <th>年龄</th>
                <th>性别</th>
                <th>联系电话</th>
                <th>健康说明</th>
                <th>申请说明</th>
                <th>审核状态</th>
                <th>审核备注</th>
                <th>申请时间</th>
                <th>审核操作</th>
            </tr>
            <% if (applyList != null && !applyList.isEmpty()) {
                for (CheckinApply apply : applyList) { %>
            <tr>
                <td><%= apply.getApplicantName() %></td>
                <td><%= apply.getElderlyName() %></td>
                <td><%= apply.getElderlyAge() %></td>
                <td><%= apply.getGender() %></td>
                <td><%= apply.getContactPhone() %></td>
                <td><%= apply.getHealthDesc() %></td>
                <td><%= apply.getApplyReason() %></td>
                <td>
                    <span class="status-badge <%= "已通过".equals(apply.getAuditStatus()) ? "status-approved" : ("已拒绝".equals(apply.getAuditStatus()) ? "status-rejected" : "status-waiting") %>">
                        <%= apply.getAuditStatus() %>
                    </span>
                </td>
                <td><%= apply.getAuditRemark() == null || apply.getAuditRemark().trim().isEmpty() ? "暂无" : apply.getAuditRemark() %></td>
                <td><%= apply.getCreateTime() %></td>
                <td>
                    <form class="compact-form" action="${pageContext.request.contextPath}/admin/apply-audit" method="post">
                        <input type="hidden" name="id" value="<%= apply.getId() %>">
                        <select name="auditStatus">
                            <option value="待审核" <%= "待审核".equals(apply.getAuditStatus()) ? "selected" : "" %>>待审核</option>
                            <option value="已通过" <%= "已通过".equals(apply.getAuditStatus()) ? "selected" : "" %>>通过</option>
                            <option value="已拒绝" <%= "已拒绝".equals(apply.getAuditStatus()) ? "selected" : "" %>>拒绝</option>
                        </select>
                        <input type="text" name="auditRemark" placeholder="填写审核备注" value="<%= apply.getAuditRemark() == null ? "" : apply.getAuditRemark() %>">
                        <button type="submit">提交审核</button>
                    </form>
                </td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="10" class="empty-state">当前暂无需要审核的入住申请记录。</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
