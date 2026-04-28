<%@ page import="java.util.List" %>
<%@ page import="com.nursinghome.entity.CheckinApply" %>
<%@ page import="com.nursinghome.entity.BedInfo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<CheckinApply> approvedApplyList = (List<CheckinApply>) request.getAttribute("approvedApplyList");
    List<BedInfo> availableBedList = (List<BedInfo>) request.getAttribute("availableBedList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>入住登记</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>入住登记</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/staff/home">工作人员首页</a>
            <a href="${pageContext.request.contextPath}/staff/care-record">护理记录管理</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="table-panel">
        <h2>已通过审核的入住申请</h2>
        <div class="section-tip">
            <strong>使用说明：</strong>当前版本采用手动入住登记方式。工作人员可参考已通过审核的申请信息，再填写正式老人档案并分配床位，不引入复杂自动联动流程。
        </div>
        <% if ("1".equals(request.getParameter("success"))) { %>
        <div class="message success">入住登记保存成功，老人档案和床位状态已更新。</div>
        <% } %>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <table>
            <tr>
                <th>申请编号</th>
                <th>申请人</th>
                <th>老人姓名</th>
                <th>年龄</th>
                <th>联系电话</th>
                <th>健康说明</th>
            </tr>
            <% if (approvedApplyList != null && !approvedApplyList.isEmpty()) {
                for (CheckinApply apply : approvedApplyList) { %>
            <tr>
                <td><%= apply.getId() %></td>
                <td><%= apply.getApplicantName() %></td>
                <td><%= apply.getElderlyName() %></td>
                <td><%= apply.getElderlyAge() %></td>
                <td><%= apply.getContactPhone() %></td>
                <td><%= apply.getHealthDesc() %></td>
            </tr>
            <% }} else { %>
            <tr>
                <td colspan="6" class="empty-state">当前暂无已通过审核的申请记录，工作人员可在有审核结果后再登记入住。</td>
            </tr>
            <% } %>
        </table>
    </div>

    <div class="panel">
        <h2>登记老人入住信息</h2>
        <form action="${pageContext.request.contextPath}/staff/checkin" method="post">
            <div class="form-grid">
                <div>
            <label>老人姓名</label>
            <input type="text" name="name" required placeholder="请输入老人姓名">
                </div>

                <div>
            <label>性别</label>
            <select name="gender" required>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
                </div>

                <div>
            <label>年龄</label>
            <input type="number" name="age" required min="50" max="120" placeholder="请输入老人年龄">
                </div>

                <div>
            <label>联系电话</label>
            <input type="text" name="phone" required placeholder="请输入联系电话">
                </div>

                <div>
            <label>家属联系人</label>
            <input type="text" name="familyContact" required placeholder="请输入家属联系人姓名">
                </div>

                <div>
            <label>家属电话</label>
            <input type="text" name="familyPhone" required placeholder="请输入家属联系电话">
                </div>

                <div class="field-full">
            <label>健康状况</label>
            <textarea name="healthCondition" required placeholder="请填写老人当前健康状况、基础疾病或护理重点"></textarea>
                </div>

                <div>
            <label>入住日期</label>
            <input type="date" name="checkinDate" required>
                </div>

                <div>
            <label>分配床位</label>
            <select name="bedId" required>
                <% if (availableBedList != null) {
                    for (BedInfo bed : availableBedList) { %>
                <option value="<%= bed.getId() %>"><%= bed.getRoomNo() %>房-<%= bed.getBedNo() %>号床（<%= bed.getBedType() %>）</option>
                <% }} %>
            </select>
            <div class="field-note">床位显示格式为“房间号-床位号（床位类型）”，请优先选择空闲床位。</div>
                </div>
            </div>

            <button type="submit">完成入住登记</button>
        </form>
    </div>
</div>
</body>
</html>
