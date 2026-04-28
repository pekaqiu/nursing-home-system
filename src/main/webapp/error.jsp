<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>提示信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
<div class="topbar">
    <div class="container">
        <h1>提示信息</h1>
    </div>
</div>
<div class="container">
    <div class="panel" style="max-width: 640px; margin: 24px auto 0;">
        <div class="message error">
            <%= request.getParameter("message") == null ? "系统处理时发生问题，请返回上一页重试。" : request.getParameter("message") %>
        </div>
        <p><a href="${pageContext.request.contextPath}/index.jsp">返回首页</a></p>
    </div>
</div>
</body>
</html>
