<?php

session_start();

require_once "php/db.php";



// ==========================================
// CHECK LOGIN
// ==========================================

if (!isset($_SESSION["user_id"])) {

    header("Location: login.html?error=login_required");
    exit();

}


// ==========================================
// GET LOGGED-IN USER
// ==========================================

$user_id = $_SESSION["user_id"];

$full_name = $_SESSION["full_name"];
$username = $_SESSION["username"];
$email = $_SESSION["email"];

// ==========================================
// GET LOGGED-IN STUDENT'S SUBJECTS
// ==========================================

$sql = "SELECT 
            subjects.subject_id,
            subjects.subject_code,
            subjects.subject_name,
            subjects.basket
        FROM student_subjects
        INNER JOIN subjects
            ON student_subjects.subject_id = subjects.subject_id
        WHERE student_subjects.user_id = ?
        ORDER BY subjects.subject_id";

$stmt = $conn->prepare($sql);

$stmt->bind_param("i", $user_id);

$stmt->execute();

$result = $stmt->get_result();

$student_subjects = [];

while ($row = $result->fetch_assoc()) {

    $student_subjects[] = $row;

}

$stmt->close();


// ==========================================
// GET STUDENT'S SUBJECTS
// ==========================================

$sql = "SELECT
            subjects.subject_id,
            subjects.subject_code,
            subjects.subject_name,
            subjects.basket
        FROM student_subjects
        INNER JOIN subjects
            ON student_subjects.subject_id = subjects.subject_id
        WHERE student_subjects.user_id = ?
        ORDER BY subjects.subject_id ASC";

$stmt = $conn->prepare($sql);

$stmt->bind_param("i", $user_id);

$stmt->execute();

$result = $stmt->get_result();

$student_subjects = [];

while ($row = $result->fetch_assoc()) {

    $student_subjects[] = $row;

}

$stmt->close();

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | A/L TechHub</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <!-- ==============================
     Navigation Bar
=============================== -->
<nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top dashboard-navbar">

    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold dashboard-brand" href="dashboard.php">
            <i class="bi bi-mortarboard-fill me-1"></i>
            A/L TechHub
        </a>


        <!-- Mobile Toggle -->
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navPortal"
            aria-controls="navPortal"
            aria-expanded="false"
            aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>


        <!-- Navbar Content -->
        <div class="collapse navbar-collapse" id="navPortal">

            <!-- Left Navigation Links -->
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
                <a
                    href="profile.html"
                    class="dashboard-user text-decoration-none"
                >
                    <i class="bi bi-person-circle me-1"></i>
                    <?php echo htmlspecialchars($full_name); ?>
                </a>

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


        <!-- Welcome Banner -->
        <div class="welcome-card p-4 rounded-4 shadow-sm mb-4">

            <div class="row align-items-center">

                <div class="col-md-7 mb-3 mb-md-0">

                    <p class="small dashboard-label mb-1">
                        STUDENT LEARNING PORTAL
                    </p>

                    <h4 class="fw-bold mb-1">
                        Welcome back, <?php echo htmlspecialchars($full_name); ?>! 👋
                    </h4>

                    <p class="text-muted small mb-0">
                        Enrolled Stream: G.C.E. A/L Technology Stream
                    </p>

                </div>


                <!-- Grade Switcher -->
                <div class="col-md-5 text-md-end">

                    <span class="small text-muted d-block mb-2">
                        Select Grade
                    </span>

                    <div
                        class="btn-group"
                        role="group"
                        aria-label="Grade selection"
                    >

                        <input
                            type="radio"
                            class="btn-check"
                            name="gradeSelect"
                            id="grade12"
                            checked
                        >

                        <label
                            class="btn btn-outline-primary fw-bold"
                            for="grade12"
                        >
                            Grade 12
                        </label>


                        <input
                            type="radio"
                            class="btn-check"
                            name="gradeSelect"
                            id="grade13"
                        >

                        <label
                            class="btn btn-outline-primary fw-bold"
                            for="grade13"
                        >
                            Grade 13
                        </label>

                    </div>

                </div>

            </div>

        </div>


        <!-- Section Heading -->
        <div class="mb-3">

            <h5 class="fw-bold mb-1">
                My Subjects
            </h5>

            <p class="text-muted small mb-0">
                Access your subjects and continue your learning.
            </p>

        </div>


        <!-- ==============================
             Subject Cards
        =============================== -->
        <div class="row g-4 mb-5">


            <?php foreach ($student_subjects as $subject): ?>

    <div class="col-md-4">

        <div class="card subject-card h-100 rounded-4 overflow-hidden">

            <!-- Subject Header -->
            <div class="subject-header">

                <span class="badge subject-badge mb-2">

                    <?php echo htmlspecialchars($subject["basket"]); ?>

                </span>

                <h5 class="fw-bold mb-0">

                    <?php echo htmlspecialchars($subject["subject_name"]); ?>

                    (<?php echo htmlspecialchars($subject["subject_code"]); ?>)

                </h5>

            </div>


            <!-- Subject Body -->
            <div class="card-body p-4 d-flex flex-column justify-content-between">

                <p class="text-muted small">

                    <?php

                    if ($subject["subject_code"] === "SFT") {

                        echo "Covers Physics, Chemistry, Mathematics, and IT basics essential for all Technology stream students.";

                    } elseif ($subject["subject_code"] === "ET") {

                        echo "Applied Engineering Systems, Civil, Electrical, and Mechanical fundamentals.";

                    } elseif ($subject["subject_code"] === "BST") {

                        echo "Biological systems, agriculture, biotechnology, and technology applications.";

                    } elseif ($subject["subject_code"] === "ICT") {

                        echo "Programming, Database Management, Networking, and Systems Architecture.";

                    } elseif ($subject["subject_code"] === "AGRI") {

                        echo "Agricultural science, crop production, animal husbandry, and modern agricultural technology.";

                    }

                    ?>

                </p>


                <!-- Progress -->
                <div>

                    <div class="d-flex justify-content-between text-muted small mb-1">

                        <span>Completed Units</span>

                        <span>0 / 0</span>

                    </div>


                    <div
                        class="progress mb-3"
                        style="height: 7px;"
                    >

                        <div
                            class="progress-bar dashboard-progress"
                            style="width: 0%;"
                        ></div>

                    </div>


                    <!-- Buttons -->
                    <div class="d-flex gap-2">

                        <a
                            href="units.php?subject=<?php echo urlencode($subject["subject_code"]); ?>"
                            class="btn btn-dashboard flex-fill fw-bold"
                        >

                            <i class="bi bi-book me-1"></i>

                            View Units

                        </a>


                        <a
                            href="past-papers.php"
                            class="btn btn-outline-primary flex-fill fw-bold"
                        >

                            <i class="bi bi-file-earmark-text me-1"></i>

                            Past Papers

                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

<?php endforeach; ?>

    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>




