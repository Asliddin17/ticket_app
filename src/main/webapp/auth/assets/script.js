// Umumiy validatsiya funksiyalari
const validateEmail = (emailInput) => {
    const isValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value);
    emailInput.classList.toggle('is-valid', isValid);
    emailInput.classList.toggle('is-invalid', !isValid && emailInput.value.length > 0);
    return isValid;
};

const validatePassword = (passwordInput) => {
    const isValid = passwordInput.value.length >= 6;
    passwordInput.classList.toggle('is-valid', isValid);
    passwordInput.classList.toggle('is-invalid', !isValid && passwordInput.value.length > 0);
    return isValid;
};
const validateFullName = (fullNameInput) => {
    const isValid = /^[A-Za-z\s']{2,}$/.test(fullNameInput.value);
    fullNameInput.classList.toggle('is-valid', isValid);
    fullNameInput.classList.toggle('is-invalid', !isValid && fullNameInput.value.length > 0);
    return isValid;
};

const validateCardNumber = (cardInput) => {
    let value = cardInput.value.replace(/\D/g, '');
    value = value.match(/.{1,4}/g)?.join(' ') || value;
    cardInput.value = value;
    const isValid = /^\d{4} \d{4} \d{4} \d{4}$/.test(value);
    cardInput.classList.toggle('is-valid', isValid);
    cardInput.classList.toggle('is-invalid', !isValid && value.length > 0);
    return isValid;
};


const validateExpiryDate = (expiryInput) => {
    let value = expiryInput.value.replace(/\D/g, '');
    if (value.length >= 2) {
        value = value.slice(0, 2) + '/' + value.slice(2);
    }
    expiryInput.value = value;
    const isValid = /^(0[1-9]|1[0-2])\/\d{2}$/.test(value);
    expiryInput.classList.toggle('is-valid', isValid);
    expiryInput.classList.toggle('is-invalid', !isValid && value.length > 0);
    return isValid;
};

const validateCvv = (cvvInput) => {
    cvvInput.value = cvvInput.value.replace(/\D/g, '');
    const isValid = /^\d{3}$/.test(cvvInput.value);
    cvvInput.classList.toggle('is-valid', isValid);
    cvvInput.classList.toggle('is-invalid', !isValid && cvvInput.value.length > 0);
    return isValid;
};

const validateAmount = (balanceInput) => {
    const value = balanceInput.value.trim();
    const isNumeric = /^[0-9]+(\.[0-9]+)?$/.test(value);
    const numberValue = parseFloat(value);
    const isValid = isNumeric && numberValue >= 0;

    balanceInput.classList.toggle('is-valid', isValid);
    balanceInput.classList.toggle('is-invalid', !isValid && value.length > 0);

    return isValid;
};


const validateFromCard = (fromCardInput) => {
    const isValid = fromCardInput.value !== '';
    fromCardInput.classList.toggle('is-valid', isValid);
    fromCardInput.classList.toggle('is-invalid', !isValid);
    return isValid;
};

// Sign In forma validatsiyasi
const signinForm = document.getElementById('signinForm');
if (signinForm) {
    const signinEmail = document.getElementById('email');
    const signinPassword = document.getElementById('password');

    signinEmail.addEventListener('input', () => validateEmail(signinEmail));
    signinPassword.addEventListener('input', () => validatePassword(signinPassword));

    signinForm.addEventListener('submit', (event) => {
        const isEmailValid = validateEmail(signinEmail);
        const isPasswordValid = validatePassword(signinPassword);

        if (!isEmailValid || !isPasswordValid) {
            event.preventDefault();
        }
    });
}

// Sign Up forma validatsiyasi
const signupForm = document.getElementById('signupForm');
if (signupForm) {
    const signupFullName = document.getElementById('fullName');
    const signupEmail = document.getElementById('email');
    const signupPassword = document.getElementById('password');

    signupFullName.addEventListener('input', () => validateFullName(signupFullName));
    signupEmail.addEventListener('input', () => validateEmail(signupEmail));
    signupPassword.addEventListener('input', () => validatePassword(signupPassword));

    signupForm.addEventListener('submit', (event) => {
        const isFullNameValid = validateFullName(signupFullName);
        const isEmailValid = validateEmail(signupEmail);
        const isPasswordValid = validatePassword(signupPassword);

        if (!isFullNameValid || !isEmailValid || !isPasswordValid) {
            event.preventDefault();
        }
    });
}

// Transfer forma validatsiyasi
const transferForm = document.getElementById('transferForm');
if (transferForm) {
    const fromCard = document.getElementById('fromCard');
    const toCard = document.getElementById('toCard');
    const amount = document.getElementById('amount');

    fromCard.addEventListener('change', () => validateFromCard(fromCard));
    toCard.addEventListener('input', () => validateCardNumber(toCard));
    amount.addEventListener('input', () => validateAmount(amount));

    transferForm.addEventListener('submit', (event) => {
        const isFromCardValid = validateFromCard(fromCard);
        const isToCardValid = validateCardNumber(toCard);
        const isAmountValid = validateAmount(amount);

        if (!isFromCardValid || !isToCardValid || !isAmountValid) {
            event.preventDefault();
            alert('Please fill in all fields correctly.');
        }
        // Agar serverga so'rov yuborish kerak bo'lsa, bu yerda `event.preventDefault()` olib tashlanadi
    });
}

// Add Card forma validatsiyasi
const addCardForm = document.getElementById('addCardForm');
if (addCardForm) {
    const cardNumber = document.getElementById('cardNumber');
    const cardHolder = document.getElementById('cardHolder');
    const balance = document.getElementById('balance');
    const expiryDate = document.getElementById('expiryDate');
    const cvv = document.getElementById('cvv');

    cardNumber.addEventListener('input', () => validateCardNumber(cardNumber));
    balance.addEventListener('input', () => validateAmount(balance));
    cardHolder.addEventListener('input', () => validateFullName(cardHolder));
    expiryDate.addEventListener('input', () => validateExpiryDate(expiryDate));
    cvv.addEventListener('input', () => validateCvv(cvv));

    balance.addEventListener('input', () => {
        balance.value = balance.value.replace(/[^0-9.]/g, '');
        const parts = balance.value.split('.');
        if (parts.length > 2) {
            balance.value = parts[0] + '.' + parts.slice(1).join('');
        }

        validateAmount(balance);
    });


    addCardForm.addEventListener('submit', (event) => {
        const isCardNumberValid = validateCardNumber(cardNumber);
        const isBalanceValid = validateAmount(balance);
        const isCardHolderValid = validateFullName(cardHolder);
        const isExpiryDateValid = validateExpiryDate(expiryDate);
        const isCvvValid = validateCvv(cvv);

        if (!isCardNumberValid ||!isBalanceValid || !isCardHolderValid || !isExpiryDateValid || !isCvvValid) {
            event.preventDefault();
            alert('Please fill in all fields correctly.');
        }
    });
}

// Logout funksiyasi
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
