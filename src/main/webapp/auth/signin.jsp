<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Sign In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/auth/assets/style.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="form-container">
        <span class="form-icon">🔑</span>
        <h2 class="form-title">Sign In</h2>
        <form id="signinForm" novalidate method="post" action="${pageContext.request.contextPath}/signin">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" name="email" class="form-control" id="email" placeholder="example@domain.com"
                       required>
                <div class="invalid-feedback">Enter a valid email address.</div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" name="pass" class="form-control" id="password" placeholder="********" required>
                <div class="invalid-feedback">Password must be at least 6 characters.</div>
            </div>
            <button type="submit" class="btn btn-primary btn-submit w-100">Sign In</button>
        </form>
        <div class="form-footer">
            Don't have an account? <a href="${pageContext.request.contextPath}/signup">Sign Up</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/auth/assets/script.js"></script>
<%--@elvariable id="message" type=""--%>
<c:if test="${not empty message}">
    <script>
        alert("${title}\n${message}");
    </script>
</c:if>
</body>
</html>
