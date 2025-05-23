<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Event Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/dashboard/assets/style.css" rel="stylesheet">
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
                <th>Name</th>
                <th>Description</th>
                <th>Date</th>
                <th>Capacity</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody id="eventTable">
            <c:forEach items="${events}" var="event">
                <tr>
                    <td>
                        <c:if test="${not empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/download?fileId=${event.attachmentId}"
                                 class="table-image" alt="Event Image" style="width: 50px; height: auto;">
                        </c:if>
                        <c:if test="${empty event.attachmentId}">
                            <img src="${pageContext.request.contextPath}/dashboard/assets/img/8136031.png"
                                 class="table-image" alt="No Image" style="width: 50px; height: auto;">
                        </c:if>
                    </td>
                    <td class="name">${event.name}</td>
                    <td class="description text-truncate" data-full="${event.description}">${event.description}</td>
                    <td>${event.date}</td>
                    <td>${event.capacity}</td>
                    <td>
                    <span class="badge
                        ${event.status == 'ACTIVE' ? 'bg-success' :
                          event.status == 'INACTIVE' ? 'bg-danger' :
                          event.status == 'CANCELLED' ? 'bg-warning' : ''}">
                            ${event.status}
                    </span>
                    </td>
                    <td>
                        <div class="dropdown">
                            <button class="btn btn-sm btn-light" type="button" data-bs-toggle="dropdown"
                                    aria-expanded="false">⋮
                            </button>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item edit-button"
                                       data-bs-toggle="modal"
                                       data-bs-target="#editModal"
                                       data-id="${event.id}"
                                       data-name="${event.name}"
                                       data-description="${event.description}"
                                       data-date="${event.date}"
                                       data-capacity="${event.capacity}"
                                       data-img="${event.attachmentId}">
                                        <i class="bi bi-pencil-square me-2"></i>Edit
                                    </a>
                                </li>
                                <li>
                                    <form action="${pageContext.request.contextPath}/delete" method="post">
                                        <input type="hidden" name="id" value="${event.id}">
                                        <button type="submit" class="dropdown-item">
                                            <i class="bi bi-trash me-2"></i>Delete
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Event</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/edit"
                          method="post" novalidate>
                        <input type="hidden" name="id">
                        <div class="mb-3">
                            <label for="editImage" class="form-label">Event Image</label>
                            <input type="file" name="img" class="form-control" id="editImage" accept="image/*">
                            <div class="image-preview-container d-none" id="editImagePreviewContainer">
                                <img id="editImagePreview" class="image-preview" alt="Image Preview">
                                <button type="button" class="remove-image" id="removeEditImage">
                                    <i class="bi bi-x" style="margin-top: 1px"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">Please upload an event image.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editName" class="form-label">Event Name</label>
                            <input type="text" class="form-control" id="editName" name="name" required minlength="3">
                            <div class="invalid-feedback">Name must be at least 3 characters.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editDescription" class="form-label">Description</label>
                            <textarea class="form-control" name="description" id="editDescription" required
                                      minlength="10"></textarea>
                            <div class="invalid-feedback">Description must be at least 10 characters.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editDate" class="form-label">Event Date</label>
                            <input type="date" class="form-control" id="editDate" name="date" required min="2025-01-01">
                            <div class="invalid-feedback">Date must be on or after January 1, 2025.</div>
                        </div>
                        <div class="mb-3">
                            <label for="editCapacity" class="form-label">Capacity</label>
                            <input type="number" class="form-control" id="editCapacity" name="capacity" required min="1"
                                   step="1">
                            <div class="invalid-feedback">Capacity must be a positive number (at least 1).</div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Edit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/dashboard/assets/script.js"></script>

<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>

<script>
    // Edit button functionality
    document.querySelectorAll('.edit-button').forEach(button => {
        button.addEventListener('click', () => {
            const id = button.getAttribute('data-id');
            const name = button.getAttribute('data-name');
            const description = button.getAttribute('data-description');
            const date = button.getAttribute('data-date');
            const capacity = button.getAttribute('data-capacity');
            const imgId = button.getAttribute('data-img');

            document.querySelector('#editForm input[name="id"]').value = id;
            document.querySelector('#editForm input[name="name"]').value = name;
            document.querySelector('#editForm textarea[name="description"]').value = description;
            document.querySelector('#editForm input[name="date"]').value = date;
            document.querySelector('#editForm input[name="capacity"]').value = capacity;

            const preview = document.getElementById('editImagePreview');
            const container = document.getElementById('editImagePreviewContainer');
            const inputFile = document.getElementById('editImage');

            if (imgId) {
                preview.src = `${pageContext.request.contextPath}/download?fileId=${imgId}`;
                container.classList.remove('d-none');
                inputFile.classList.add('image-input-hidden');
            } else {
                container.classList.add('d-none');
                inputFile.classList.remove('image-input-hidden');
            }
        });
    });

    // Input validation for edit form
    document.querySelectorAll('#editForm input, #editForm textarea').forEach(input => {
        input.addEventListener('input', () => {
            if (input.id === 'editCapacity') {
                input.value = input.value.replace(/[^0-9]/g, '');
                if (input.value === '0' || parseInt(input.value) < 1) {
                    input.value = '';
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                }
            }
            if (input.id === 'editDate') {
                // Ensure date is on or after 2025
                const selectedDate = new Date(input.value);
                const minDate = new Date('2025-01-01');
                const year = input.value.split('-')[0];
                if (year.length !== 4 || selectedDate < minDate) {
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                    input.setCustomValidity('Date must be on or after January 1, 2025.');
                } else {
                    input.setCustomValidity('');
                }
            }
            if (input.checkValidity()) {
                input.classList.remove('is-invalid');
                input.classList.add('is-valid');
            } else {
                input.classList.remove('is-valid');
                input.classList.add('is-invalid');
            }
        });
    });

    // Image upload and preview for edit form
    document.getElementById('editImage').addEventListener('change', function () {
        const file = this.files[0];
        const preview = document.getElementById('editImagePreview');
        const previewContainer = document.getElementById('editImagePreviewContainer');
        if (file) {
            preview.src = URL.createObjectURL(file);
            previewContainer.classList.remove('d-none');
            this.classList.add('image-input-hidden');
            this.classList.remove('is-invalid');
            this.classList.add('is-valid');
        } else {
            previewContainer.classList.add('d-none');
            this.classList.remove('image-input-hidden');
            this.classList.add('is-invalid');
        }
    });

    document.getElementById('removeEditImage').addEventListener('click', function () {
        const input = document.getElementById('editImage');
        const previewContainer = document.getElementById('editImagePreviewContainer');
        input.value = '';
        previewContainer.classList.add('d-none');
        input.classList.remove('image-input-hidden');
        input.classList.add('is-invalid');
        input.classList.remove('is-valid');
    });

    // Form submission validation
    const editForm = document.getElementById('editForm');
    editForm.addEventListener('submit', function (event) {
        if (!editForm.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
            editForm.querySelectorAll('input, textarea').forEach(input => {
                if (!input.checkValidity()) {
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                }
            });
        }
        // Custom date validation
        const eventDate = document.getElementById('editDate');
        const selectedDate = new Date(eventDate.value);
        const minDate = new Date('2025-01-01');
        const year = eventDate.value.split('-')[0];
        if (eventDate.value && (year.length !== 4 || selectedDate < minDate)) {
            eventDate.setCustomValidity('Date must be on or after January 1, 2025.');
            eventDate.classList.add('is-invalid');
            eventDate.classList.remove('is-valid');
        } else {
            eventDate.setCustomValidity('');
        }
        editForm.classList.add('was-validated');
    }, false);

    // Description truncation
    document.querySelectorAll('.description').forEach(cell => {
        const fullText = cell.getAttribute('data-full');
        if (fullText.length > 65) {
            cell.innerHTML = fullText.substring(0, 75) + '<br>' + fullText.substring(75, 150) + '...';
        } else {
            cell.textContent = fullText;
        }
    });
</script>
</body>
</html>
