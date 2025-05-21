<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Title</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/auth/assets/style.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="form-container">
        <span class="form-icon">📝</span>
        <h2 class="form-title">Sign Up</h2>
        <form id="signupForm" method="post" action="/signup" novalidate>
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" name="name" class="form-control" id="fullName" placeholder="John Doe" required>
                <div class="invalid-feedback">Enter a valid name (at least 2 characters).</div>
            </div>
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
            <button type="submit" class="btn btn-primary btn-submit w-100">Sign Up</button>
        </form>
        <div class="form-footer">
            Already have an account? <a href="/signin">Sign In</a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/auth/assets/script.js"></script>

</body>
</html>
