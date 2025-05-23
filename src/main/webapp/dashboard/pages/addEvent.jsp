<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Add New Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #f8f9fa;
            padding-top: 20px;
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
            display: none !important;
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
        <h2 class="text-center mb-4">Add New Event</h2>
        <form id="eventForm" method="post" action="${pageContext.request.contextPath}/event"
              enctype="multipart/form-data" novalidate>
            <div class="mb-3">
                <label for="eventImage" class="form-label">Event Image</label>
                <input type="file" class="form-control" id="eventImage" accept="image/*" name="img" required>
                <div class="image-preview-container d-none" id="imagePreviewContainer">
                    <img id="imagePreview" class="image-preview" src="#" alt="Image Preview">
                    <button type="button" class="remove-image" id="removeImage"><i style="margin-top: 1px"
                                                                                   class="bi bi-x"></i></button>
                </div>
                <div class="invalid-feedback">Please upload an event image.</div>
            </div>
            <div class="mb-3">
                <label for="eventName" class="form-label">Event Name</label>
                <input type="text" class="form-control" name="name" id="eventName" required minlength="3">
                <div class="invalid-feedback">Event name must be at least 3 characters.</div>
            </div>
            <div class="mb-3">
                <label for="eventDate" class="form-label">Event Date</label>
                <input type="date" class="form-control" name="date" id="eventDate" required min="2025-01-01">
                <div class="invalid-feedback">Please select a date on or after January 1, 2025.</div>
            </div>
            <div class="mb-3">
                <label for="eventCapacity" class="form-label">Capacity</label>
                <input type="number" class="form-control" name="capacity" id="eventCapacity" required min="1" step="1">
                <div class="invalid-feedback">Capacity must be a positive number (at least 1).</div>
            </div>
            <div class="mb-3">
                <label for="eventDescription" class="form-label">Description</label>
                <textarea class="form-control" name="description" id="eventDescription" required
                          minlength="10"></textarea>
                <div class="invalid-feedback">Description must be at least 10 characters.</div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Add Event</button>
            </div>
        </form>
    </div>
</div>

<script>
    // Logout functionality
    const logoutBtn = document.getElementById('logout-btn');
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            fetch('/logout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (response.ok) {
                        localStorage.clear();
                        sessionStorage.clear();
                        window.location.href = '/';
                    } else {
                        alert('Logout failed. Please try again.');
                    }
                })
                .catch(() => {
                    alert('An error occurred during logout.');
                });
        });
    }

    // Input validation for all form fields
    document.querySelectorAll('#eventForm input, #eventForm textarea').forEach(input => {
        input.addEventListener('input', () => {
            if (input.id === 'eventCapacity') {
                // Ensure capacity is a positive integer >= 1
                input.value = input.value.replace(/[^0-9]/g, ''); // Allow only digits
                if (input.value === '0' || parseInt(input.value) < 1) {
                    input.value = '';
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                }
            }
            if (input.id === 'eventDate') {
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

    // Image upload and preview
    const imageInput = document.getElementById('eventImage');
    const imagePreview = document.getElementById('imagePreview');
    const imagePreviewContainer = document.getElementById('imagePreviewContainer');
    const removeImageButton = document.getElementById('removeImage');

    imageInput.addEventListener('change', function () {
        const file = this.files[0];
        if (file) {
            imagePreview.src = URL.createObjectURL(file);
            imagePreviewContainer.classList.remove('d-none');
            imageInput.classList.add('image-input-hidden');
            imageInput.classList.remove('is-invalid');
            imageInput.classList.add('is-valid');
        } else {
            imagePreviewContainer.classList.add('d-none');
            imageInput.classList.remove('image-input-hidden');
            imageInput.classList.add('is-invalid');
        }
    });

    removeImageButton.addEventListener('click', function () {
        imageInput.value = '';
        imagePreview.src = '#';
        imagePreviewContainer.classList.add('d-none');
        imageInput.classList.remove('image-input-hidden');
        imageInput.classList.add('is-invalid');
        imageInput.classList.remove('is-valid');
    });

    // Form submission validation
    const form = document.getElementById('eventForm');
    form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
            form.querySelectorAll('input, textarea').forEach(input => {
                if (!input.checkValidity()) {
                    input.classList.add('is-invalid');
                    input.classList.remove('is-valid');
                }
            });
        }
        // Custom date validation
        const eventDate = document.getElementById('eventDate');
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
        form.classList.add('was-validated');
    }, false);

    // Dropdown item click (if applicable)
    document.querySelectorAll('.dropdown-item').forEach(item => {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            const modal = new bootstrap.Modal(document.getElementById('editModal'));
            modal.show();
        });
    });

    // Server message alert
    <c:if test="${not empty message}">
    alert("${message}");
    </c:if>
</script>
</body>
</html>
