<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/dashboard/assets/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>

    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user">Product Management</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                </li>
                <li class="nav-item">
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/basket">
                        <i class="bi bi-basket fs-5 m-1"></i> <span>Basket</span>
                    </a>
                </li>

                <li class="nav-item me-3 dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#"
                       role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-credit-card fs-5 me-1 m-1"></i> <span>Card</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/card">Add Card</a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/card-list">Show Card</a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/fill">Fill balance</a>
                        </li>

                    </ul>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown"
                       role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-5 me-1"></i> <span>Account</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <form action="${pageContext.request.contextPath}/logout" method="post" class="px-3">
                                <button type="submit" class="btn btn-outline-danger btn-sm w-100">Log Out</button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <h1 class="text-center mb-4">Product Catalog</h1>
    <div class="search-container">
        <div class="input-group">
            <form action="${pageContext.request.contextPath}/search" method="POST" class="input-group">
                <label for="searchInput" class="visually-hidden">Search products</label>
                <input type="text" name="keyword" id="searchInput" class="form-control"
                       placeholder="Search products...">
                <button type="submit" class="btn btn-outline-secondary">Search</button>
            </form>
        </div>
    </div>
    <div id="userView" class="row row-cols-1 row-cols-md-3 g-4">

        <%--@elvariable id="products" type=""--%>
        <c:forEach items="${products}" var="pr">
            <div class="col">
                <div class="card product-card h-100">
                    <div class="product-image">
                        <img src="${pageContext.request.contextPath}/download?fileId=${pr.attachmentId}" alt="Laptop">
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${pr.name}</h5>
                        <p class="card-text flex-grow-1">${pr.description}</p>

                        <div class="d-flex align-items-center justify-content-between">
                            <p class="card-text mb-0"><strong>Price:</strong> ${pr.price}$</p>
                            <form action="${pageContext.request.contextPath}/basket" method="post">
                                <label>
                                    <input type="text" value="${pr.id}" name="productId" hidden="hidden">
                                </label>
                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="bi bi-basket2 me-1"></i> <span>Add Basket</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="${pageContext.request.contextPath}/dashboard/assets/script.js"></script>
</body>
</html>
