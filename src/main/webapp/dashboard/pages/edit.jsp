<%--
  Created by IntelliJ IDEA.
  User: aslid
  Date: 5/25/2025
  Time: 4:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/assets/style.css" rel="stylesheet">
    <style>
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
        <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">Event Management</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/dashboard">
                        <i class="bi bi-table"></i> <span>Events</span>
                    </a>
                </li>
                <li class="nav-item me-3">
                    <a class="nav-link position-relative" href="${pageContext.request.contextPath}/product">
                        <i class="bi bi-plus-circle"></i> <span>Add Event</span>
                    </a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdown"
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-5 me-1"></i> <span>Account</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">My Profile</a></li>
                        <li><hr class="dropdown-divider"></li>
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

<div class="container my-5 pt-5">
    <h1 class="text-center mb-4">Edit Event</h1>

    <!-- Display error/success message -->
    <c:if test="${not empty message}">
        <div class="alert alert-${message.contains('successfully') ? 'success' : 'danger'} alert-dismissible fade show" role="alert">
                ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${empty eventDTO}">
        <div class="alert alert-danger" role="alert">
            Event not found. Please go back to the <a href="${pageContext.request.contextPath}/dashboard">dashboard</a>.
        </div>
    </c:if>

    <c:if test="${not empty eventDTO}">
        <form id="editForm" enctype="multipart/form-data" action="${pageContext.request.contextPath}/edit" method="post" novalidate>
            <input type="hidden" name="id" value="${eventDTO.id}">
            <div class="mb-3">
                <label for="editImage" class="form-label">Event Image</label>
                <input type="file" name="img" class="form-control" id="editImage" accept="image/*">
                <div class="image-preview-container ${not empty eventDTO.attachmentId ? '' : 'd-none'}" id="editImagePreviewContainer">
                    <img id="editImagePreview" class="image-preview"
                         src="${not empty eventDTO.attachmentId ? pageContext.request.contextPath.concat('/download?fileId=').concat(eventDTO.attachmentId) : ''}"
                         alt="Image Preview">
                    <button type="button" class="remove-image" id="removeEditImage">
                        <i class="bi bi-x" style="margin-top: 1px"></i>
                    </button>
                </div>
                <div class="invalid-feedback">Please upload a valid image (max 5MB).</div>
            </div>
            <div class="mb-3">
                <label for="editName" class="form-label">Event Name</label>
                <input type="text" class="form-control" id="editName" name="name" value="${eventDTO.name}" required minlength="3">
                <div class="invalid-feedback">Name must be at least 3 characters.</div>
            </div>
            <div class="mb-3">
                <label for="editDescription" class="form-label">Description</label>
                <textarea class="form-control" name="description" id="editDescription" required minlength="10">${eventDTO.description}</textarea>
                <div class="invalid-feedback">Description must be at least 10 characters.</div>
            </div>
            <div class="mb-3">
                <label for="editDate" class="form-label">Event Date</label>
                <input type="date" class="form-control" id="editDate" name="date" value="${eventDTO.date}" required min="2025-01-01">
                <div class="invalid-feedback">Date must be on or after January 1, 2025.</div>
            </div>
            <div class="mb-3">
                <label for="editCapacity" class="form-label">Capacity</label>
                <input type="number" class="form-control" id="editCapacity" name="capacity" value="${eventDTO.capacity}" required min="1" step="1">
                <div class="invalid-feedback">Capacity must be a positive number (at least 1).</div>
            </div>
            <div class="mb-3">
                <label for="editStatus" class="form-label">Status</label>
                <select class="form-control" id="editStatus" name="status" required>
                    <option value="ACTIVE" ${eventDTO.status == 'ACTIVE' ? 'selected' : ''}>Active</option>
                    <option value="INACTIVE" ${eventDTO.status == 'INACTIVE' ? 'selected' : ''}>Inactive</option>
                    <option value="CANCELLED" ${eventDTO.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                </select>
                <div class="invalid-feedback">Please select a status.</div>
            </div>
            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-primary me-2">Save Changes</button>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </c:if>
</div>

<script src="${pageContext.request.contextPath}/assets/script.js"></script>
<script>
    // Input validation
    document.querySelectorAll('#editForm input, #editForm textarea, #editForm select').forEach(input => {
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

    // Image upload and preview
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
    if (editForm) {
        editForm.addEventListener('submit', function (event) {
            if (!editForm.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
                editForm.querySelectorAll('input, textarea, select').forEach(input => {
                    if (!input.checkValidity()) {
                        input.classList.add('is-invalid');
                        input.classList.remove('is-valid');
                    }
                });
            }
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
    }
</script>
</body>
</html>
