<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Konsert uchun Joy Tanlash</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .stadium {
            background: linear-gradient(to bottom, #f8fafc, #e2e8f0);
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .scene {
            background: #1e293b;
            border-radius: 8px 8px 0 0;
        }
        .seat {
            border-radius: 6px;
            transition: transform 0.2s, background-color 0.2s;
        }
        .seat:hover:not(.bg-gray-400) {
            transform: scale(1.1);
        }
        .info-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
        }
        .form-control, .btn {
            border-radius: 8px;
        }
        .btn-primary {
            background: #2563eb;
            border: none;
            transition: background 0.3s;
        }
        .btn-primary:hover {
            background: #1d4ed8;
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col p-6">
<h1 class="text-3xl font-bold text-gray-800 mb-6 text-center">Konsert uchun Joy Tanlash</h1>
<div class="container mx-auto flex flex-col md:flex-row gap-6">
    <!-- Left: Info, Price, Card Selection, Submit -->
    <div class="md:w-1/3 info-card">
        <h3 class="text-lg font-semibold text-gray-700 mb-3">Tanlangan joylar:</h3>
        <p id="selected-seats" class="text-gray-600 mb-4">Hech narsa tanlanmadi</p>
        <h3 class="text-lg font-semibold text-gray-700 mb-3">Umumiy narx:</h3>
        <p id="total-price" class="text-gray-600 mb-4">0.00 UZS</p>
        <form id="booking-form" action="${pageContext.request.contextPath}/payment" method="POST">
            <input type="hidden" name="eventId" value="${param.eventId}">
            <input type="hidden" name="placeName" id="placeName">
            <div class="mb-4">
                <label for="cardSelect" class="form-label text-sm font-medium text-gray-700">Karta tanlang</label>
                <select class="form-control" id="cardSelect" name="cardId" required>
                    <option value="">Karta tanlang</option>
                    <c:forEach items="${cards}" var="cd">
                        <option value="${cd.id}">${cd.cardNumber}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" id="book-button"
                    class="w-full px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed">
                Sotib olish <i class="bi bi-cart-check ms-2"></i>
            </button>
        </form>
    </div>
    <!-- Right: Seat Selection -->
    <div class="md:w-2/3 stadium p-4">
        <div class="scene w-full h-16 text-white text-center flex items-center justify-center">
            <span class="text-lg font-semibold">Sahna</span>
        </div>
        <div id="sectors-container" class="mt-4">
            <!-- Sectors and seats will be generated here -->
        </div>
    </div>
</div>
<script>
    const sectorsContainer = document.getElementById('sectors-container');
    const selectedSeatsDisplay = document.getElementById('selected-seats');
    const totalPriceDisplay = document.getElementById('total-price');
    const bookButton = document.getElementById('book-button');
    const bookingForm = document.getElementById('booking-form');
    const placeNameInput = document.getElementById('placeName');
    const cardSelect = document.getElementById('cardSelect');

    // Backenddan kelgan ma'lumotlar
    const places = [
        <c:forEach items="${places}" var="place" varStatus="status">
        {
            placeNumber: "${place.placeNumber}",
            eventId: "${place.eventId}",
            capacity: ${place.capacity},
            price: ${place.price != null ? place.price : 10.0}
        }<c:if test="${!status.last}">, </c:if>
        </c:forEach>
    ];

    // places[0].price ni konsolda ko‘rsatish
    if (places.length > 0) {
        console.log('Places:', places[0].price);
    } else {
        console.log('Places bo‘sh, default narx: 10.0');
    }

    const eventId = places.length > 0 ? places[0].eventId : "${param.eventId}";
    let totalSeats = places.length > 0 ? places[0].capacity : 1;
    // Bron qilingan joylar ro'yxati (A1, A2 kabi)
    const occupiedSeats = places.map(p => p.placeNumber);

    // Debug uchun occupiedSeats ni konsolda ko‘rsatish
    console.log('Occupied Seats:', occupiedSeats);

    if (places.length === 0) {
        fetch(`/api/event/${eventId}/capacity`, {
            method: 'GET',
            headers: {'Content-Type': 'application/json'}
        })
            .then(response => response.json())
            .then(data => {
                totalSeats = data.capacity || 1;
                generateSeats();
            })
            .catch(error => {
                console.error('Error fetching capacity:', error);
                generateSeats();
            });
    } else {
        generateSeats();
    }

    function generateSeats() {
        const sectorsCount = Math.min(4, Math.ceil(totalSeats / 40));
        const seatsPerSector = Math.ceil(totalSeats / sectorsCount);
        const cols = Math.min(10, seatsPerSector);
        const rows = Math.ceil(seatsPerSector / cols);

        // places[0].price dan narx olish, agar bo‘sh bo‘lsa 10.0
        const seatPrice = places.length > 0 && places[0].price > 0 ? places[0].price : 10.0;

        sectorsContainer.innerHTML = '';
        for (let sector = 0; sector < sectorsCount; sector++) {
            const sectorDiv = document.createElement('div');
            sectorDiv.classList.add('sector', 'mb-6');
            const sectorLabel = document.createElement('h4');
            sectorLabel.classList.add('text-lg', 'font-semibold', 'text-gray-700', 'mb-2');
            sectorLabel.textContent = 'Sektor ' + String.fromCharCode(65 + sector);
            sectorDiv.appendChild(sectorLabel);

            const seatGrid = document.createElement('div');
            seatGrid.classList.add('grid', 'grid-cols-' + cols, 'gap-2');

            for (let i = 0; i < rows * cols && (sector * seatsPerSector + i) < totalSeats; i++) {
                const seatIndex = sector * seatsPerSector + i;
                const seat = document.createElement('div');
                seat.classList.add('seat', 'w-10', 'h-10', 'rounded-md', 'border', 'border-gray-300', 'cursor-pointer', 'transition-all', 'duration-200', 'bg-green-300', 'hover:bg-green-400', 'flex', 'items-center', 'justify-center', 'text-xs', 'font-semibold');
                const seatLabel = String.fromCharCode(65 + sector) + (i + 1);
                seat.textContent = seatLabel;
                seat.dataset.price = seatPrice;
                seat.title = seatPrice.toFixed(2) + ' UZS'; // Narxni tooltip sifatida ko‘rsatish
                if (occupiedSeats.includes(seatLabel)) {
                    seat.classList.add('bg-gray-400', 'cursor-not-allowed');
                    seat.classList.remove('hover:bg-green-400', 'bg-green-300');
                } else {
                    seat.addEventListener('click', () => toggleSeat(seat, seatIndex, seatLabel, seatPrice));
                }
                seatGrid.appendChild(seat);
            }
            sectorDiv.appendChild(seatGrid);
            sectorsContainer.appendChild(sectorDiv);
        }
    }

    let selectedSeats = [];

    function toggleSeat(seat, index, seatLabel, price) {
        if (seat.classList.contains('bg-blue-500')) {
            seat.classList.remove('bg-blue-500', 'border-blue-600');
            seat.classList.add('bg-green-300', 'hover:bg-green-400');
            selectedSeats = selectedSeats.filter(s => s.index !== index);
        } else if (!seat.classList.contains('bg-gray-400')) {
            seat.classList.remove('bg-green-300', 'hover:bg-green-400');
            seat.classList.add('bg-blue-500', 'border-blue-600');
            selectedSeats.push({ index, label: seatLabel, price });
        }
        updateSelectedSeatsDisplay();
        updateTotalPrice();
        updateBookButton();
    }

    function updateSelectedSeatsDisplay() {
        if (selectedSeats.length === 0) {
            selectedSeatsDisplay.textContent = 'Hech narsa tanlanmadi';
            placeNameInput.value = '';
        } else {
            const labels = selectedSeats.map(s => s.label).join(',');
            selectedSeatsDisplay.textContent = labels;
            placeNameInput.value = labels;
        }
    }

    function updateTotalPrice() {
        const total = selectedSeats.reduce((sum, seat) => sum + seat.price, 0);
        totalPriceDisplay.textContent = total.toFixed(2) + ' UZS';
    }

    function updateBookButton() {
        bookButton.disabled = selectedSeats.length === 0 || !cardSelect.value;
        bookButton.classList.toggle('opacity-50', bookButton.disabled);
        bookButton.classList.toggle('cursor-not-allowed', bookButton.disabled);
    }

    cardSelect.addEventListener('change', updateBookButton);

    bookingForm.addEventListener('submit', (e) => {
        e.preventDefault();
        if (selectedSeats.length === 0) {
            alert('Iltimos, kamida bitta joy tanlang!');
        } else if (!cardSelect.value) {
            alert('Iltimos, karta tanlang!');
        } else {
            bookingForm.submit();
        }
    });
</script>
</body>
</html>
