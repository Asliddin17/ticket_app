<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <script src="${pageContext.request.contextPath}/dashboard/assets/script.js"></script>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #f8f9fa;
            padding-top: 20px; /* Adjust for fixed navbar */
        }

        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }

        .form-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            background: #fff;
        }

        .form-control {
            border-radius: 5px;
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

        .image-preview-container {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }

        .image-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .image-input-hidden {
            display: none;
        }

        .remove-image {
            position: absolute;
            top: -5px;
            right: 175px;
            background: #c21e1e;
            color: #ffffff;
            border: none;
            border-radius: 50%;
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 14px;
        }
    </style>

</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">Product Management</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/admin">
                        <i class="bi bi-table"></i> <span>Products</span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/product">
                        <i class="bi bi-plus-circle"></i> <span>Add product</span>
                    </a>
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


<div class="container my-5 form-container">
    <div class="form-card p-4">
        <h2 class="text-center mb-4">Add New Product</h2>
        <form id="productForm" method="post" action="${pageContext.request.contextPath}/event"
              enctype="multipart/form-data" novalidate>
            <div class="mb-3">
                <label for="imagePreview" id="imagePreviewLabel" class="form-label">Product Image</label>
                <input type="file" class="form-control" id="productImage" accept="image/*" name="img" content=""
                       required>
                <div class="image-preview-container d-none" id="imagePreviewContainer">
                    <img id="imagePreview" class="image-preview" src="#" alt="Image Preview">
                    <button type="button" class="remove-image" id="removeImage"><i style="margin-top: 1px"
                                                                                   class="bi bi-x"></i></button>
                </div>
            </div>
            <div class="mb-3">
                <label for="productName" class="form-label">Product Name</label>
                <input type="text" class="form-control" name="name" id="productName" required minlength="3">
                <div class="invalid-feedback">Name must be at least 3 characters.</div>
            </div>
            <div class="mb-3">
                <label for="productDescription" class="form-label">Description</label>
                <textarea class="form-control" name="description" id="productDescription" required
                          minlength="10"></textarea>
                <div class="invalid-feedback">Description must be at least 10 characters.</div>
            </div>
            <div class="mb-3">
                <label for="productPrice" class="form-label">Price (USD)</label>
                <input type="text" class="form-control" name="price" id="productPrice" pattern="^[0-9]+(\.[0-9]{1,2})?$"
                       required>
                <div class="invalid-feedback">Price must be a positive number.</div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Add Product</button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/dashboard/assets/script.js"></script>

<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</body>
</html>
