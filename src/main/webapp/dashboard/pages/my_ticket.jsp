<%--
  Created by IntelliJ IDEA.
  User: jahon
  Date: 21/05/2025
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>My tickets</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/dashboard/assets/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .table td.description {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 300px;
        }

        .table td.name {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 150px;
        }

        .is-invalid {
            border-color: #dc3545 !important;
        }

        .is-valid {
            border-color: #198754 !important;
        }

        .image-input-hidden {
            display: none !important;
        }

        .image-preview {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        .image-preview-container {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
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
                       href="${pageContext.request.contextPath}/history">
                        <i class="bi bi-clock-history fs-5"></i>
                        <span>History</span>
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
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-1" href="#" id="navbarDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-5"></i>
                        <span>Account</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
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
    <h1 class="text-center mb-4">Event Management</h1>
    <div class="search-container">
        <div class="input-group">
            <form action="${pageContext.request.contextPath}/search" method="POST" class="input-group">
                <label for="searchInput" class="visually-hidden">Search events</label>
                <input type="text" name="keyword" id="searchInput" class="form-control"
                       placeholder="Search events...">
                <button type="submit" class="btn btn-outline-secondary">Search</button>
            </form>
        </div>
    </div>
    <div class="table-container table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>Image</th>
                <th>Event Name</th>
                <th>Place Number</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${tickets}" var="ticket">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${not empty ticket.attachmentId}">
                                <img src="${pageContext.request.contextPath}/download?fileId=${ticket.attachmentId}"
                                     alt="Event Image" style="width: 50px; height: auto;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/dashboard/assets/img/8136031.png"
                                     alt="No Image" style="width: 50px; height: auto;">
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${ticket.eventName}</td>
                    <td>${ticket.placeNumber}</td>
                    <td><span class="bg-success badge">${ticket.status}</span></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/cancel?ticketId=${ticket.id}" method="post"
                              style="display:inline;">
                            <input type="hidden" name="ticketId" value="${ticket.id}">
                            <button type="submit" class="btn btn-sm btn-danger">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

    </div>
</div>

</body>
</html>
