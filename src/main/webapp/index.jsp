<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 70px;
        }

        .hero-section {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
            margin-top: 20px;
        }

        .hero-section h1 {
            color: #007bff;
        }

        .hero-section p {
            color: #6c757d;
            font-size: 1.1rem;
        }

        .btn-primary {
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            transition: background-color 0.2s;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .btn-outline-primary {
            border-color: #007bff;
            color: #007bff;
            border-radius: 5px;
            padding: 10px 20px;
        }

        .btn-outline-primary:hover {
            background-color: #007bff;
            color: #fff;
        }

    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">Eventix</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/signup">
                        <button class="btn btn-outline-primary me-2">Sign Up</button>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/signin">
                        <button class="btn btn-primary">Sign In</button>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="hero-section">
        <h1>Welcome to Product Management</h1>
        <p>Manage your products with ease, whether you're a user browsing our catalog or an admin overseeing inventory.
            Sign up or sign in to get started!</p>
        <div class="mt-4">
            <a href="${pageContext.request.contextPath}/signup">
                <button class="btn btn-outline-primary me-2">Sign Up</button>
            </a>
            <a href="${pageContext.request.contextPath}/signin">
                <button class="btn btn-primary">Sign In</button>
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
