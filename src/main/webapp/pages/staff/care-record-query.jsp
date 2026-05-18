<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.CareRecord" %>
<%@ page import="com.nursinghome.entity.ElderlyProfile" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<CareRecord> careRecordList = (List<CareRecord>) request.getAttribute("careRecordList");
    List<ElderlyProfile> elderlyList = (List<ElderlyProfile>) request.getAttribute("elderlyList");
    Integer selectedElderlyId = (Integer) request.getAttribute("selectedElderlyId");
    String selectedCareDate = (String) request.getAttribute("selectedCareDate");
    Boolean onlyMine = (Boolean) request.getAttribute("onlyMine");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>护理记录查询</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>护理记录查询</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">护工首页</a>
            <a href="${pageContext.request.contextPath}/staff/pending-checkin">待登记名单查看</a>
            <a href="${pageContext.request.contextPath}/staff/checkin">入住登记</a>
            <a href="${pageContext.request.contextPath}/staff/care-record">护理记录管理</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel">
        <h2>查询条件</h2>
        <form action="${pageContext.request.contextPath}/staff/care-record-query" method="get">
            <div class="form-grid">
                <div>
                    <label>老人姓名</label>
                    <select name="elderlyId">
                        <option value="">全部老人</option>
                        <% if (elderlyList != null) {
                            for (ElderlyProfile elderly : elderlyList) { %>
                        <option value="<%= elderly.getId() %>" <%= selectedElderlyId != null && selectedElderlyId.equals(elderly.getId()) ? "selected" : "" %>><%= elderly.getName() %></option>
                        <% }} %>
                    </select>
                </div>

                <div>
                    <label>护理日期</label>
                    <input type="date" name="careDate" value="<%= selectedCareDate == null ? "" : selectedCareDate %>">
                </div>

                <div>
                    <label>记录范围</label>
                    <select name="onlyMine">
                        <option value="0" <%= Boolean.TRUE.equals(onlyMine) ? "" : "selected" %>>全部记录</option>
                        <option value="1" <%= Boolean.TRUE.equals(onlyMine) ? "selected" : "" %>>仅本人录入</option>
                    </select>
                </div>
            </div>
            <button type="submit">开始查询</button>
        </form>
    </div>

    <div class="table-panel">
        <h2>护理记录查询结果</h2>
        <table>
            <tr>
                <th>老人姓名</th>
                <th>护工</th>
                <th>护理内容</th>
                <th>身体情况</th>
                <th>护理时间</th>
                <th>备注</th>
            </tr>
            <% if (careRecordList != null && !careRecordList.isEmpty()) {
                for (CareRecord record : careRecordList) { %>
            <tr>
                <td><%= record.getElderlyName() %></td>
                <td><%= record.getStaffName() %></td>
                <td><%= record.getCareContent() %></td>
                <td><%= record.getBodyCondition() %></td>
                <td><%= record.getCareTime() %></td>
                <td><%= record.getRemark() == null ? "" : record.getRemark() %></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="6" class="empty-state">当前条件下暂无护理记录。</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
