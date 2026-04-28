<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>入住申请</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>入住申请</h1>
        <div class="nav">
            <a href="${pageContext.request.contextPath}/user/home">普通用户首页</a>
            <a href="${pageContext.request.contextPath}/user/apply?action=my">我的申请记录</a>
        </div>
    </div>
</div>
<div class="container">
    <div class="panel" style="max-width: 760px; margin: 20px auto 0;">
        <div class="section-tip">
            <strong>填写说明：</strong>请如实填写老人基本情况、联系方式和健康说明，提交后系统会自动生成“待审核”状态，管理员审核后可在“我的申请记录”中查看结果。
        </div>
        <% if (request.getAttribute("errorMessage") != null) { %>
        <div class="message error"><%= request.getAttribute("errorMessage") %></div>
        <% } %>
        <form action="${pageContext.request.contextPath}/user/apply" method="post">
            <div class="form-grid">
                <div>
            <label>老人姓名</label>
            <input type="text" name="elderlyName" required placeholder="请输入老人姓名">
                </div>

                <div>
            <label>老人年龄</label>
            <input type="number" name="elderlyAge" required placeholder="请输入老人年龄" min="50" max="120">
                </div>

                <div>
            <label>性别</label>
            <select name="gender" required>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
                </div>

                <div>
            <label>联系电话</label>
            <input type="text" name="contactPhone" required placeholder="请输入联系电话">
                </div>

                <div class="field-full">
            <label>健康说明</label>
            <textarea name="healthDesc" required placeholder="例如：是否有慢性病、近期身体状况、日常照护重点"></textarea>
            <div class="field-note">请使用正式、清楚的中文描述老人当前身体状况，方便后续审核与护理安排。</div>
                </div>

                <div class="field-full">
            <label>申请说明</label>
            <textarea name="applyReason" required placeholder="例如：申请入住原因、家属陪护情况、希望入住时间"></textarea>
                </div>
            </div>

            <button type="submit">提交申请</button>
        </form>
    </div>
</div>
</body>
</html>
