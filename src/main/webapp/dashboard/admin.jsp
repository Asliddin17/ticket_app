<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .table-image {
            width: 50px;
            height: auto;
            border-radius: 5px;
        }
        .description {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .name {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">Product Management</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                        <i class="bi bi-table"></i> Products
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link" href="${pageContext.request.contextPath}/product">
                        <i class="bi bi-plus-circle"></i> Add Product
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> Account
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li>
                            <form action="${pageContext.request.contextPath}/logout" method="post">
                                <button type="submit" class="dropdown-item btn btn-outline-danger">Log Out</button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5 pt-4">
    <h1 class="text-center mb-4">Event Management</h1>
    <div class="row mb-3">
        <div class="col-md-6 offset-md-3">
            <form action="${pageContext.request.contextPath}/search" method="POST" class="input-group">
                <input type="text" name="keyword" class="form-control" placeholder="Search events...">
                <button type="submit" class="btn btn-outline-secondary">Search</button>
            </form>
        </div>
    </div>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead>
            <tr>
                <th>Image</th>
                <th>Name</th>
                <th>Description</th>
                <th>Date</th>
                <th>Capacity</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${events}" var="event">
                <tr>
                    <td>
                        <c:if test="${not empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/download?fileId=${event.attachmentId}"
                                 class="table-image" alt="Event Image">
                        </c:if>
                        <c:if test="${empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/dashboard/assets/img/8136031.png"
                                 class="table-image" alt="No Image">
                        </c:if>
                    </td>
                    <td class="name">${event.name}</td>
                    <td class="description" data-full="${event.description}">${event.description}</td>
                    <td>${event.date}</td>
                    <td>${event.capacity}</td>
                    <td>
                        <span class="badge ${event.status == 'ACTIVE' ? 'bg-success' : event.status == 'INACTIVE' ? 'bg-danger' : 'bg-warning'}">
                                ${event.status}
                        </span>
                    </td>
                    <td>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">⋮</button>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item btn btn-outline-primary edit-button"
                                       data-bs-toggle="modal" data-bs-target="#editModal"
                                       data-id="${event.id}"
                                       data-eventName="${event.name}"
                                       data-date="${event.date}"
                                       data-capacity="${event.capacity}"
                                       data-attachmentId="${event.attachmentId}"
                                       data-status="${event.status}"
                                       data-description="${event.description}">
                                        <i class="bi bi-pencil-square me-2"></i>Edit
                                    </a>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/changeStatus" method="post">
                                        <input type="hidden" name="eventId" value="${event.id}">
                                        <input type="hidden" name="status" value="INACTIVE">
                                        <button type="submit" class="dropdown-item btn btn-outline-danger">
                                            <i class="bi bi-trash me-2"></i>Delete
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/changeStatus" method="post">
                                        <input type="hidden" name="eventId" value="${event.id}">
                                        <input type="hidden" name="status" value="CANCELLED">
                                        <button type="submit" class="dropdown-item btn btn-outline-warning">
                                            <i class="bi bi-x me-2"></i>Cancel
                                        </button>
                                    </form>
                                </li>
                                <c:if test="${event.status == 'CANCELLED'}">
                                    <li>
                                        <form action="${pageContext.request.contextPath}/changeStatus" method="post">
                                            <input type="hidden" name="eventId" value="${event.id}">
                                            <input type="hidden" name="status" value="ACTIVE">
                                            <button type="submit" class="dropdown-item btn btn-outline-success">
                                                <i class="bi bi-check-circle me-2"></i>Activate
                                            </button>
                                        </form>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm" action="${pageContext.request.contextPath}/my-tickets" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="id" id="eventId">
                        <input type="hidden" name="existingAttachmentId" id="existingAttachmentId">
                        <div class="mb-3">
                            <label for="eventName" class="form-label">Event Name</label>
                            <input type="text" class="form-control" id="eventName" name="eventName" required minlength="3">
                            <div class="invalid-feedback">Name must be at least 3 characters.</div>
                        </div>
                        <div class="mb-3">
                            <label for="date" class="form-label">Event Date</label>
                            <input type="date" class="form-control" id="date" name="date" required min="2025-01-01">
                            <div class="invalid-feedback">Date must be on or after January 1, 2025.</div>
                        </div>
                        <div class="mb-3">
                            <label for="capacity" class="form-label">Capacity</label>
                            <input type="number" class="form-control" id="capacity" name="capacity" required min="1" step="1">
                            <div class="invalid-feedback">Capacity must be a positive number (at least 1).</div>
                        </div>
                        <div class="mb-3">
                            <label for="attachmentId" class="form-label">Event Image</label>
                            <input type="file" class="form-control" id="attachmentId" name="attachmentId" accept="image/*">
                            <div class="invalid-feedback">Please upload an event image (optional).</div>
                        </div>
                        <div class="mb-3">
                            <label for="status" class="form-label">Status</label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="ACTIVE">ACTIVE</option>
                                <option value="INACTIVE">INACTIVE</option>
                                <option value="CANCELLED">CANCELLED</option>
                            </select>
                            <div class="invalid-feedback">Please select a status.</div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" required minlength="10"></textarea>
                            <div class="invalid-feedback">Description must be at least 10 characters.</div>
                        </div>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Edit button functionality with enhanced error handling
    document.querySelectorAll('.edit-button').forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id') || '';
            const eventName = button.getAttribute('data-eventName') || '';
            const date = button.getAttribute('data-date') || '';
            const capacity = button.getAttribute('data-capacity') || '';
            const attachmentId = button.getAttribute('data-attachmentId') || '';
            const status = button.getAttribute('data-status') || 'ACTIVE';
            const description = button.getAttribute('data-description') || '';

            console.log('Edit button clicked with data:', { id, eventName, date, capacity, attachmentId, status, description });

            // DOM elementlarni tekshirish
            const form = document.getElementById('editForm');
            if (!form) {
                console.error('Edit form not found!');
                return;
            }

            const eventIdInput = document.getElementById('eventId');
            const eventNameInput = document.getElementById('eventName');
            const dateInput = document.getElementById('date');
            const capacityInput = document.getElementById('capacity');
            const existingAttachmentIdInput = document.getElementById('existingAttachmentId');
            const statusSelect = document.getElementById('status');
            const descriptionTextarea = document.getElementById('description');

            if (!eventIdInput || !eventNameInput || !dateInput || !capacityInput || !existingAttachmentIdInput || !statusSelect || !descriptionTextarea) {
                console.error('One or more input elements not found!');
                return;
            }

            // Qiymatlarni o'rnatish
            eventIdInput.value = id;
            eventNameInput.value = eventName;
            dateInput.value = date;
            capacityInput.value = capacity;
            existingAttachmentIdInput.value = attachmentId;
            statusSelect.value = status;
            descriptionTextarea.value = description;

            console.log('Form values set:', {
                id: eventIdInput.value,
                eventName: eventNameInput.value,
                date: dateInput.value,
                capacity: capacityInput.value,
                existingAttachmentId: existingAttachmentIdInput.value,
                status: statusSelect.value,
                description: descriptionTextarea.value
            });
        });
    });

    // Form submission with debug
    const editForm = document.getElementById('editForm');
    if (editForm) {
        editForm.addEventListener('submit', function (event) {
            if (!editForm.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                console.log('Form validation failed. Invalid fields:', editForm.querySelectorAll(':invalid'));
            } else {
                console.log('Form submitted with values:', {
                    id: editForm.querySelector('input[name="id"]').value,
                    eventName: editForm.querySelector('input[name="eventName"]').value,
                    date: editForm.querySelector('input[name="date"]').value,
                    capacity: editForm.querySelector('input[name="capacity"]').value,
                    existingAttachmentId: editForm.querySelector('input[name="existingAttachmentId"]').value,
                    status: editForm.querySelector('select[name="status"]').value,
                    description: editForm.querySelector('textarea[name="description"]').value
                });
            }
            editForm.classList.add('was-validated');
        });
    } else {
        console.error('Edit form not found on page load!');
    }

    // Description truncation
    document.querySelectorAll('.description').forEach(cell => {
        const fullText = cell.getAttribute('data-full');
        if (fullText && fullText.length > 65) {
            cell.innerHTML = fullText.substring(0, 75) + '<br>' + fullText.substring(75, 150) + '...';
        } else {
            cell.textContent = fullText || '';
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
