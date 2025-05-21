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

<div class="container my-5">
    <h1 class="text-center mb-4">Product Management</h1>
    <div class="payment-container mb-4">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#paymentModal">
            <i class="bi bi-credit-card me-2"></i> Pay Total:
            <c:set var="total" value="${0}"/>
            <c:forEach items="${products}" var="pr">
                <c:set var="total" value="${total + pr.price}"/>
            </c:forEach>
            $${total}
        </button>
    </div>
    <div class="table-container table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Description</th>
                <th>Price</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="productTable">
            <c:forEach items="${products}" var="pr">
                <tr>
                    <td><img src="${pageContext.request.contextPath}/download?fileId=${pr.attachmentId}"
                             class="table-image" alt="404"
                             style="width: 50px; height: auto;"></td>
                    <td>${pr.name}</td>
                    <td class="description text-truncate" data-full="${pr.description}">${pr.description}</td>
                    <td>${pr.price}</td>
                    <td>
                        <form action="">
                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                <i class="bi bi-trash me-2"></i> Remove
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="paymentModalLabel">Confirm Payment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p class="fw-bold">Total Amount:
                        <c:set var="total" value="${0}"/>
                        <c:forEach items="${products}" var="pr">
                            <c:set var="total" value="${total + pr.price}"/>
                        </c:forEach>
                        $${total}
                    </p>
                    <form action="${pageContext.request.contextPath}/payment" method="post">
                        <div class="mb-3">
                            <label for="cardSelect" class="form-label">Select Card</label>
                            <select class="form-control" id="cardSelect" name="card" required>
                                <option value="">Select a card</option>
                                <c:forEach items="${cards}" var="cd">
                                    <option value="${cd.id}">${cd.cardNumber}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <div class="form-check">
                                <label class="form-check-label" for="chequeRequest">
                                    Do you want cheque ?
                                </label>
                                <input class="form-check-input" type="checkbox" name="cheque" id="chequeRequest">
                            </div>
                        </div>
                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel
                            </button>
                            <button type="submit" class="btn btn-primary">Confirm Payment</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>



<script>
    document.querySelectorAll('.description').forEach(cell => {
        const fullText = cell.getAttribute('data-full');
        if (fullText.length > 65) {
            cell.innerHTML = fullText.substring(0, 75) + '<br>' + fullText.substring(75, 150) + '...';
        } else {
            cell.textContent = fullText;
        }
    });
</script>

<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>
</body>
</html>
