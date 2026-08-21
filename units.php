<?php

session_start();


// ==========================================
// CHECK LOGIN
// ==========================================

if (!isset($_SESSION["user_id"])) {

    header("Location: login.html?error=login_required");
    exit();

}


// ==========================================
// GET LOGGED-IN STUDENT
// ==========================================

$full_name = $_SESSION["full_name"];


// ==========================================
// GET SELECTED SUBJECT
// ==========================================

$subject_code = $_GET["subject"] ?? "";

?>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Units | A/L TechHub</title>


    <!-- Bootstrap -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
    >


    <!-- Bootstrap Icons -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css"
        rel="stylesheet"
    >


    <!-- Main CSS -->

    <link
        rel="stylesheet"
        href="css/style.css"
    >

</head>


<body>


<!-- ==============================
     Navigation Bar
=============================== -->

<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top dashboard-navbar">

    <div class="container">


        <!-- Brand -->

        <a
            class="navbar-brand fw-bold dashboard-brand"
            href="dashboard.php"
        >

            <i class="bi bi-mortarboard-fill me-1"></i>

            A/L TechHub

        </a>


        <!-- Mobile Toggle -->

        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navPortal"
        >

            <span class="navbar-toggler-icon"></span>

        </button>


        <!-- Navigation -->

        <div
            class="collapse navbar-collapse"
            id="navPortal"
        >

            <ul class="navbar-nav me-auto ms-lg-4">

                <li class="nav-item">

                    <a
                        class="nav-link dashboard-nav-link"
                        href="index.php"
                    >

                        <i class="bi bi-house me-1"></i>

                        Home

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link dashboard-nav-link active"
                        href="dashboard.php"
                    >

                        <i class="bi bi-grid-1x2-fill me-1"></i>

                        Dashboard

                    </a>

                </li>


                <li class="nav-item">

                    <a
                        class="nav-link dashboard-nav-link"
                        href="contact.php"
                    >

                        <i class="bi bi-envelope me-1"></i>

                        Contact Us

                    </a>

                </li>

            </ul>


            <!-- Right Side -->

            <div class="d-flex align-items-center gap-3">

                <span class="dashboard-user">

                    <i class="bi bi-person-circle me-1"></i>

                    <?php echo htmlspecialchars($full_name); ?>

                </span>


                <a
                    href="php/logout.php"
                    class="btn btn-outline-primary btn-sm px-3"
                >

                    <i class="bi bi-box-arrow-right me-1"></i>

                    Logout

                </a>

            </div>

        </div>

    </div>

</nav>



<!-- ==============================
     Main Content
=============================== -->

<main class="container py-4">


    <!-- Back -->

    <div class="mb-3">

        <a
            href="dashboard.php"
            class="text-decoration-none"
        >

            <i class="bi bi-arrow-left me-1"></i>

            Back to Dashboard

        </a>

    </div>


    <!-- Page Header -->

    <div class="welcome-card p-4 rounded-4 shadow-sm mb-4">

        <p class="small dashboard-label mb-1">

            STUDENT LEARNING PORTAL

        </p>


        <h3 class="fw-bold mb-1">

            <?php echo htmlspecialchars($subject_code); ?>

            Units

        </h3>


        <p class="text-muted small mb-0">

            Select a unit to continue your learning.

        </p>

    </div>


    <!-- ==============================
         Units
    =============================== -->

    <div class="row g-4">


        <!-- Unit 01 -->

        <div class="col-md-6">

            <div class="card subject-card h-100 rounded-4">

                <div class="card-body p-4">


                    <span class="badge subject-badge mb-3">

                        Unit 01

                    </span>


                    <h5 class="fw-bold">

                        Introduction

                    </h5>


                    <p class="text-muted small">

                        Learn the basic concepts and
                        fundamentals of this subject.

                    </p>


                    <a
                        href="#"
                        class="btn btn-dashboard fw-bold"
                    >

                        <i class="bi bi-book me-1"></i>

                        Open Unit

                    </a>

                </div>

            </div>

        </div>



        <!-- Unit 02 -->

        <div class="col-md-6">

            <div class="card subject-card h-100 rounded-4">

                <div class="card-body p-4">


                    <span class="badge subject-badge mb-3">

                        Unit 02

                    </span>


                    <h5 class="fw-bold">

                        Basic Concepts

                    </h5>


                    <p class="text-muted small">

                        Explore the important concepts
                        related to this subject.

                    </p>


                    <a
                        href="#"
                        class="btn btn-dashboard fw-bold"
                    >

                        <i class="bi bi-book me-1"></i>

                        Open Unit

                    </a>

                </div>

            </div>

        </div>


    </div>

</main>



<!-- Bootstrap JavaScript -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
></script>


</body>

</html>
