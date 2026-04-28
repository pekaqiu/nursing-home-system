<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.CareRecord" %>
<%@ page import="com.nursinghome.entity.ElderlyProfile" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<CareRecord> careRecordList = (List<CareRecord>) request.getAttribute("careRecordList");
    List<ElderlyProfile> elderlyList = (List<ElderlyProfile>) request.getAttribute("elderlyList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>护理记录管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>护理记录管理</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">工作人员首页</a>
            <a href="${pageContext.request.contextPath}/staff/checkin">入住登记</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel">
        <h2>新增护理记录</h2>
        <div class="section-tip">
            <strong>填写说明：</strong>护理记录用于登记老人当日护理情况和身体状态，请使用简洁、正式的中文描述，便于后续查询和论文截图展示。
        </div>
        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message success">护理记录保存成功。</div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/staff/care-record" method="post">
            <div class="form-grid">
                <div>
            <label>老人姓名</label>
            <select name="elderlyId" required>
                <% if (elderlyList != null) {
                    for (ElderlyProfile elderly : elderlyList) { %>
                <option value="<%= elderly.getId() %>"><%= elderly.getName() %></option>
                <% }} %>
            </select>
                </div>

                <div>
            <label>护理时间</label>
            <input type="datetime-local" name="careTime" required>
                </div>

                <div class="field-full">
            <label>护理内容</label>
            <textarea name="careContent" required placeholder="例如：协助进餐、服药提醒、生活起居照护"></textarea>
                </div>

                <div class="field-full">
            <label>身体情况</label>
            <textarea name="bodyCondition" required placeholder="例如：精神状态平稳、睡眠正常、血压偏高需持续观察"></textarea>
                </div>

                <div class="field-full">
            <label>备注</label>
            <textarea name="remark" placeholder="可填写需要家属关注或后续护理跟进的内容"></textarea>
                </div>
            </div>

            <button type="submit">保存护理记录</button>
        </form>
    </div>

    <div class="table-panel">
        <h2>护理记录列表</h2>
        <table>
            <tr>
                <th>老人姓名</th>
                <th>工作人员</th>
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
                <td colspan="6" class="empty-state">当前暂无护理记录，工作人员可先填写并保存护理内容。</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
