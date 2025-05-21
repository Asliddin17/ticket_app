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

document.querySelectorAll('#productForm input, #productForm textarea, #productForm select').forEach(input => {
    input.addEventListener('input', () => {
        if (input.id === 'productPrice') {
            input.value = input.value.replace(/[^0-9.]/g, '');
            if (input.value.split('.').length > 2) {
                input.value = input.value.slice(0, -1);
            }
            if (input.value.includes('.') && input.value.split('.')[1].length > 2) {
                input.value = input.value.slice(0, -1);
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

document.getElementById('productImage').addEventListener('change', function () {
    const file = this.files[0];
    const preview = document.getElementById('imagePreview');
    const previewLabel = document.getElementById('imagePreviewLabel');
    const previewContainer = document.getElementById('imagePreviewContainer');
    if (file) {
        preview.src = URL.createObjectURL(file);
        previewLabel.src = URL.createObjectURL(file);
        previewLabel.style.display = 'none';
        previewContainer.classList.remove('d-none');
        this.classList.add('image-input-hidden');
    }
});

document.getElementById('removeImage').addEventListener('click', function () {
    const input = document.getElementById('productImage');
    const previewContainer = document.getElementById('imagePreviewContainer');
    const previewLabel = document.getElementById('imagePreviewLabel');
    input.value = '';
    previewContainer.classList.add('d-none');
    previewLabel.style.display = 'block';
    input.classList.remove('image-input-hidden');
});



document.querySelectorAll('.dropdown-item').forEach(item => {
    item.addEventListener('click', function (e) {
        e.preventDefault();
        const modal = new bootstrap.Modal(document.getElementById('editModal'));
        modal.show();
    });
});

