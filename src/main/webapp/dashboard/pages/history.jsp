<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/dashboard/assets/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

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

<div class="container">
    <div class="table-container">
        <h2 class="table-title">Cards List</h2>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Ticket status</th>
                <th scope="col">Event name</th>
                <th scope="col">Date</th>
                <th scope="col">By</th>
            </tr>
            </thead>
            <tbody>
            <c:set var="i" value="1"/>
            <c:forEach items="${history}" var="h">
                <tr>
                    <th scope="row">${i}</th>
                    <td>${h.ticket.status}</td>
                    <td>${h.event.name}</td>
                    <td>${h.date}</td>
                    <td>${h.by}</td>
                </tr>
                <c:set var="i" value="${i + 1}"/>
            </c:forEach>

            </tbody>
        </table>
    </div>
</div>
</body>
</html>
