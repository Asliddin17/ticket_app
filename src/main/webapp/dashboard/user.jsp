<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 70px;
            font-family: 'Arial', sans-serif;
        }
        .event-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            height: 100%;
        }
        .event-card:hover {
            transform: translateY(-3px);
        }
        .search-image-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            transition: background-color 0.2s;
        }
        .search-image-btn:hover {
            background-color: #0056b3;
        }
        .event-image {
            width: 100%;
            height: 0;
            padding-bottom: 75%; /* 4:3 aspect ratio */
            position: relative;
            border-radius: 10px 10px 0 0;
            background-color: #ffffff;
        }
        .event-image img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: contain;
            object-position: center;
        }
        .search-container {
            max-width: 600px;
            margin: 0 auto 20px;
        }
        .card-body {
            padding: 15px;
        }
        .btn-logout {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 8px 15px;
        }
        .btn-logout:hover {
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
            right: -5px;
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
        .footer {
            background-color: #f8f9fa;
            padding: 20px 0;
            text-align: center;
            font-size: 0.9rem;
            color: #6c757d;
        }
        .badge {
            font-size: 0.9em;
        }
        .is-invalid {
            border-color: #dc3545 !important;
        }
        .is-valid {
            border-color: #198754 !important;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/user">Event Management</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"></li>
                <li class="nav-item"></li>
            </ul>
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <a class="nav-link d-flex align-items-center gap-1"
                       href="${pageContext.request.contextPath}/basket">
                        <i class="bi bi-cart2 fs-5" style="margin-top: -2px"></i>
                        <span>Basket</span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link d-flex align-items-center gap-1"
                       href="${pageContext.request.contextPath}/my-tickets">
                        <i class="bi bi-ticket-detailed fs-5"></i>
                        <span>My Tickets</span>
                    </a>
                </li>
                <li class="nav-item me-3 dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-1" href="#" role="button"
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-credit-card fs-5"></i>
                        <span>Card</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/card">Add Card</a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/card-list">Show Card</a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/fill">Fill balance</a>
                        </li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-1" href="#" id="navbarDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-5"></i>
                        <span>Account</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <form action="${pageContext.request.contextPath}/logout" method="post" class="px-3">
                                <button type="submit" class="btn btn-logout btn-sm w-100">Log Out</button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <h1 class="text-center mb-4">Events</h1>
    <div class="search-container">
        <div class="input-group">
            <form action="${pageContext.request.contextPath}/search" method="POST" class="input-group">
                <label for="searchInput" class="visually-hidden">Search events</label>
                <input type="text" name="keyword" id="searchInput" class="form-control"
                       placeholder="Search events...">
                <button type="submit" class="btn search-image-btn">Search</button>
            </form>
        </div>
    </div>
    <div id="userView" class="row row-cols-1 row-cols-md-3 g-4">
        <c:forEach items="${events}" var="event">
            <div class="col">
                <div class="card event-card h-100">
                    <div class="event-image">
                        <c:if test="${not empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/download?fileId=${event.attachmentId}"
                                 alt="Event Image">
                        </c:if>
                        <c:if test="${empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/assets/placeholder.png"
                                 alt="No Image">
                        </c:if>
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${event.name}</h5>
                        <p class="card-text flex-grow-1">${event.description}</p>
                        <p class="card-text"><strong>Date:</strong> ${event.date}</p>
                        <p class="card-text"><strong>Capacity:</strong> ${event.capacity}</p>
                        <p class="card-text">
                            <strong>Status:</strong>
                            <span class="badge
                                ${event.status == 'ACTIVE' ? 'bg-success' :
                                  event.status == 'INACTIVE' ? 'bg-danger' :
                                  event.status == 'CANCELLED' ? 'bg-secondary' : ''}">
                                    ${event.status}
                            </span>
                        </p>
                        <div class="d-flex align-items-center justify-content-end">
                            <form action="${pageContext.request.contextPath}/basket" method="post">
                                <input type="hidden" value="${event.id}" name="eventId">
                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="bi bi-ticket me-1"></i> <span>Buy ticket</span>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<footer class="footer">
    <p>&copy; 2025 Event Management System. All rights reserved.</p>
</footer>

<script src="${pageContext.request.contextPath}/dashboard/assets/script.js"></script>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</body>
</html>
