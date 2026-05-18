<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.CheckinApply" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<CheckinApply> approvedApplyList = (List<CheckinApply>) request.getAttribute("approvedApplyList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>待登记名单查看</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>待登记名单查看</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">护工首页</a>
            <a href="${pageContext.request.contextPath}/staff/checkin">入住登记</a>
            <a href="${pageContext.request.contextPath}/staff/care-record">护理记录管理</a>
            <a href="${pageContext.request.contextPath}/staff/care-record-query">护理记录查询</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>已通过审核、待护工处理的申请</h2>
        <div class="section-tip">
            <strong>功能说明：</strong>本页面只用于查看待护工处理的入住对象，帮助护工提前了解老人情况与审核备注，再进入入住登记页面办理正式入住。
        </div>
        <div class="actions">
            <a class="button-link button-secondary" href="${pageContext.request.contextPath}/staff/checkin">前往入住登记</a>
        </div>
        <table>
            <tr>
                <th>申请编号</th>
                <th>申请人</th>
                <th>老人姓名</th>
                <th>年龄</th>
                <th>性别</th>
                <th>联系电话</th>
                <th>健康说明</th>
                <th>审核备注</th>
                <th>申请时间</th>
            </tr>
            <% if (approvedApplyList != null && !approvedApplyList.isEmpty()) {
                for (CheckinApply apply : approvedApplyList) { %>
            <tr>
                <td><%= apply.getId() %></td>
                <td><%= apply.getApplicantName() %></td>
                <td><%= apply.getElderlyName() %></td>
                <td><%= apply.getElderlyAge() %></td>
                <td><%= apply.getGender() %></td>
                <td><%= apply.getContactPhone() %></td>
                <td><%= apply.getHealthDesc() %></td>
                <td><%= apply.getAuditRemark() == null || apply.getAuditRemark().trim().isEmpty() ? "暂无" : apply.getAuditRemark() %></td>
                <td><%= apply.getCreateTime() %></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="9" class="empty-state">当前暂无待护工处理的通过申请记录。</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
