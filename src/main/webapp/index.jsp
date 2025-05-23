<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Eventix - Explore Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .hero {
            padding: 80px 0;
            text-align: center;
            background: linear-gradient(to right, #ffffff, #e9ecef);
        }

        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
            color: #343a40;
        }

        .hero p {
            font-size: 1.2rem;
            color: #6c757d;
            margin-bottom: 30px;
        }

        .btn-custom {
            border-radius: 30px;
            padding: 10px 30px;
            font-weight: 500;
        }

        .event-card {
            transition: 0.3s;
        }

        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }

        .footer {
            background-color: #f8f9fa;
            text-align: center;
            padding: 20px 0;
            font-size: 0.9rem;
            color: #6c757d;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="/">Eventix</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item me-2">
                    <a class="btn btn-outline-primary btn-custom" href="${pageContext.request.contextPath}/signup">Sign Up</a>
                </li>
                <li class="nav-item">
                    <a class="btn btn-primary btn-custom" href="${pageContext.request.contextPath}/signin">Sign In</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Carousel -->
<div style="margin-top: 10px" id="eventCarousel" class="carousel slide my-5" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://galaktika-omsk.ru/_next/image/?url=https%3A%2F%2Fgalaktika-omsk.ru%2Fupload%2Fb%2Ffile_189_4864.jpg&w=3840&q=100" class="d-block w-100" alt="Event 1">
        </div>
        <div class="carousel-item">
            <img src="https://d34080pnh6e62j.cloudfront.net/images/contentCategoryMoblieLarge/1738326942_web-category-banner-size-1920x600px.jpg" class="d-block w-100" alt="Event 2">
        </div>
        <div class="carousel-item">
            <img src="https://flyimg.pm-kino.de/upload/q_60,w_2000/https%3A%2F%2Friesa.filmpalast.de%2Fwp-content%2Fuploads%2Fsites%2F12%2F2025%2F05%2FMI8_Filmpalast_Herobanner_Desktop_1920x600_AB.jpg" class="d-block w-100" alt="Event 3">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#eventCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#eventCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon"></span>
    </button>
</div>

<!-- Events Cards -->
<div class="container mb-5">
    <h2 class="mb-4 text-center">Upcoming Events</h2>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card event-card">
                <img src="https://cdn.iticket.uz/event/poster_square/cxohftxTIjMmOyjZTUnJ68yZrMIfZMnHxGy2D9vM.jpg" class="card-img-top" alt="Concert">
                <div class="card-body">
                    <h5 class="card-title">Rock Concert</h5>
                    <p class="card-text">Feel the energy with top bands live in your city.</p>
                    <p class="text-primary fw-bold">$29.99</p>
                    <a href="${pageContext.request.contextPath}/signin" class="btn btn-outline-primary btn-sm">Buy Ticket</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card event-card">
                <img src="dashboard/assets/img/matchday.png" class="card-img-top" alt="Conference">
                <div class="card-body">
                    <h5 class="card-title">Tech Conference 2025</h5>
                    <p class="card-text">Meet top speakers and learn the future of AI & Java.</p>
                    <p class="text-primary fw-bold">$99.00</p>
                    <a href="${pageContext.request.contextPath}/signin" class="btn btn-outline-primary btn-sm">Buy Ticket</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card event-card">
                <img src="https://papers.co/wallpaper/papers.co-bi63-avengers-poster-hero-endgame-marvel-film-poster-art-1-wallpaper.jpg" class="card-img-top" alt="Football Match">
                <div class="card-body">
                    <h5 class="card-title">Championship Finals</h5>
                    <p class="card-text">Watch the most intense football match of the season!</p>
                    <p class="text-primary fw-bold">$49.99</p>
                    <a href="${pageContext.request.contextPath}/signin" class="btn btn-outline-primary btn-sm">Buy Ticket</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="container">
        &copy; 2025 Eventix. All rights reserved.
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
