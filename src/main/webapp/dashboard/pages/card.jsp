<%--
  Created by IntelliJ IDEA.
  User: jahon
  Date: 08/05/2025
  Time: 23:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link href="${pageContext.request.contextPath}/dashboard/assets/style.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Arial', sans-serif;
            padding-top: 70px;
        }

        .form-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            border-top: 5px solid #007bff;
        }

        .form-title {
            text-align: center;
            margin-bottom: 25px;
            color: #343a40;
            font-weight: bold;
            font-size: 1.8rem;
        }

        .form-icon {
            font-size: 2.5rem;
            color: #007bff;
            margin-bottom: 15px;
            display: block;
            text-align: center;
        }

        .form-control {
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .form-control:focus {
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .is-invalid {
            border-color: #dc3545;
        }

        .is-valid {
            border-color: #28a745;
        }

        .btn-submit {
            padding: 12px;
            font-size: 1.1rem;
            border-radius: 50px;
            background: linear-gradient(135deg, #007bff, #6610f2);
            border: none;
            transition: transform 0.2s;
        }

        .btn-submit:hover {
            transform: scale(1.05);
        }

        @media (max-width: 576px) {
            .form-container {
                padding: 20px;
            }

            .form-title {
                font-size: 1.5rem;
            }

            .form-icon {
                font-size: 2rem;
            }
        }

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
                                <button type="submit" class="btn btn-outline-danger btn-sm w-100">Log Out</button>
                            </form>
                        </li>
                    </ul>
                </li>

            </ul>
        </div>
    </div>
</nav>


<div class="container" style="margin-top: -50px">
    <div class="form-container">
        <span class="form-icon">💳</span>
        <h2 class="form-title">Add New Card</h2>
        <form id="addCardForm" action="${pageContext.request.contextPath}/card" method="post" novalidate>
            <div class="mb-3">
                <label for="cardNumber" class="form-label">Card Number</label>
                <input type="text" class="form-control" id="cardNumber" name="number" placeholder="1234 5678 9012 3456"
                       maxlength="19"
                       required>
                <div class="invalid-feedback">Enter a valid 16-digit card number.</div>
            </div>
            <div class="mb-3">
                <label for="cardHolder" class="form-label">Card Holder Name</label>
                <input type="text" class="form-control" name="holder" id="cardHolder" placeholder="John Doe" required>
                <div class="invalid-feedback">Enter a valid name.</div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label for="expiryDate" class="form-label">Expiry Date</label>
                    <input type="text" class="form-control" name="date" id="expiryDate" placeholder="MM/YY"
                           maxlength="5" required>
                    <div class="invalid-feedback">Enter a valid expiry date (MM/YY).</div>
                </div>
                <div class="col-md-6 mb-3">
                    <label for="cvv" class="form-label">CVV</label>
                    <input type="text" class="form-control" name="cvv" id="cvv" placeholder="123" maxlength="3"
                           required>
                    <div class="invalid-feedback">Enter a valid 3-digit CVV.</div>
                </div>
                <div class="mb-3">
                    <label for="balance" class="form-label">Initial balance</label>
                    <input type="text" class="form-control" name="balance" id="balance" placeholder="" required>
                    <div class="invalid-feedback">Enter a valid balance.</div>
                </div>
            </div>
            <button type="submit" class="btn btn-primary btn-submit w-100">Add Card</button>
        </form>
    </div>
</div>


<script src="${pageContext.request.contextPath}/auth/assets/script.js"></script>

<c:if test="${not empty message}">
    <script>
        alert("${title}\n${message}");
    </script>
</c:if>


</body>
</html>
