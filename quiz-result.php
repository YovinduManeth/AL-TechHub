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
// CHECK QUIZ SESSION
// ==========================================

if (
    !isset($_SESSION["active_quiz_id"]) ||
    !isset($_SESSION["quiz_questions"])
) {

    header("Location: dashboard.php");
    exit();

}


$quiz_id = (int)$_SESSION["active_quiz_id"];

$selected_question_ids = $_SESSION["quiz_questions"];


// ==========================================
// GET QUIZ DETAILS
// ==========================================

$sql = "SELECT
            quiz_id,
            unit_id,
            title,
            time_limit
        FROM quizzes
        WHERE quiz_id = ?";

$stmt = $conn->prepare($sql);

$stmt->bind_param("i", $quiz_id);

$stmt->execute();

$result = $stmt->get_result();

$quiz = $result->fetch_assoc();

$stmt->close();


if (!$quiz) {

    header("Location: dashboard.php");
    exit();

}


// ==========================================
// GET SELECTED QUESTIONS
// ==========================================

$questions = [];

foreach ($selected_question_ids as $question_id) {

    $sql = "SELECT
                question_id,
                question_text,
                option_a,
                option_b,
                option_c,
                option_d,
                correct_answer
            FROM quiz_questions
            WHERE question_id = ?
            AND quiz_id = ?";

    $stmt = $conn->prepare($sql);

    $stmt->bind_param(
        "ii",
        $question_id,
        $quiz_id
    );

    $stmt->execute();

    $result = $stmt->get_result();

    $question = $result->fetch_assoc();

    if ($question) {

        $questions[] = $question;

    }

    $stmt->close();

}


// ==========================================
// CALCULATE SCORE
// ==========================================

$correct_count = 0;

$total_questions = count($questions);

$marks_per_question = 10;


foreach ($questions as $question) {

    $question_id = $question["question_id"];

    $submitted_answer =
        $_POST["question_" . $question_id] ?? "";

    $correct_answer =
        $question["correct_answer"];


    if ($submitted_answer === $correct_answer) {

        $correct_count++;

    }

}


// ==========================================
// CALCULATE MARKS
// ==========================================

$score =
    $correct_count * $marks_per_question;

$total_marks =
    $total_questions * $marks_per_question;


// ==========================================
// CALCULATE PERCENTAGE
// ==========================================

$percentage = 0;

if ($total_marks > 0) {

    $percentage =
        ($score / $total_marks) * 100;

}


// ==========================================
// PASS / FAIL
// ==========================================

$pass_mark = 50;

$passed =
    ($percentage >= $pass_mark);

?>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Quiz Results | A/L TechHub</title>


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


<body class="quiz-result-page">


    <!-- =========================================
         NAVIGATION BAR
    ========================================== -->

    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top dashboard-navbar">

        <div class="container">


            <!-- Brand -->

            <a
                class="navbar-brand fw-bold dashboard-brand"
                href="dashboard.html"
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
                aria-controls="navPortal"
                aria-expanded="false"
                aria-label="Toggle navigation"
            >

                <span class="navbar-toggler-icon"></span>

            </button>


            <!-- Navbar Content -->

            <div
                class="collapse navbar-collapse"
                id="navPortal"
            >


                <!-- Navigation Links -->

                <ul class="navbar-nav me-auto ms-lg-4">


                    <li class="nav-item">

                        <a
                            class="nav-link dashboard-nav-link"
                            href="index.html"
                        >

                            <i class="bi bi-house me-1"></i>

                            Home

                        </a>

                    </li>


                    <li class="nav-item">

                        <a
                            class="nav-link dashboard-nav-link active"
                            href="dashboard.html"
                        >

                            <i class="bi bi-grid-1x2-fill me-1"></i>

                            Dashboard

                        </a>

                    </li>


                    <li class="nav-item">

                        <a
                            class="nav-link dashboard-nav-link"
                            href="help.html"
                        >

                            <i class="bi bi-question-circle me-1"></i>

                            Help

                        </a>

                    </li>


                    <li class="nav-item">

                        <a
                            class="nav-link dashboard-nav-link"
                            href="contact.html"
                        >

                            <i class="bi bi-envelope me-1"></i>

                            Contact Us

                        </a>

                    </li>

                </ul>


                <!-- User -->

                <div class="d-flex align-items-center gap-3">

                    <a
                        href="profile.html"
                        class="dashboard-user text-decoration-none"
                    >
                        <i class="bi bi-person-circle me-1"></i>
                        User Account
                    </a>


                    <a
                        href="login.html"
                        class="btn btn-outline-primary btn-sm px-3"
                    >

                        <i class="bi bi-box-arrow-right me-1"></i>

                        Logout

                    </a>

                </div>

            </div>

        </div>

    </nav>



    <!-- =========================================
         MAIN CONTENT
    ========================================== -->

    <main class="container py-5">


        <div class="row justify-content-center">

            <div class="col-lg-8">


                <!-- =====================================
                     RESULT HEADER
                ====================================== -->

                <div class="result-card text-center mb-4">


                    <!-- Icon -->

                    <div class="result-icon">

                        <i class="bi bi-trophy-fill"></i>

                    </div>


                    <!-- Heading -->

                    <span class="result-label">
                        UNIT 01 ASSESSMENT
                    </span>

                    <h2 class="result-title">
                        Quiz Completed!
                    </h2>


                    <p class="result-description">
                        Unit 01: Fundamentals of Physics & Measurement
                        <span class="d-block mt-1">
                            <?php echo $correct_count; ?>
                                out of
                                <?php echo $total_questions; ?>
                                questions answered correctly
                        </span>
                    </p>



                    <!-- Score -->

                    <div class="result-score-box">

                        <span class="result-score-label">
                            Your Total Score
                        </span>


                       <div class="result-score">

                            <?php echo $score; ?>

                            / 

                            <?php echo $total_marks; ?>

                        </div>

                            <span class="result-status">

                                <?php if ($passed): ?>

                                    <i class="bi bi-check-circle-fill me-1"></i>

                                    Passed

                                <?php else: ?>

                                    <i class="bi bi-x-circle-fill me-1"></i>

                                    Failed

                                <?php endif; ?>

                            </span>
                    </div>



                    <!-- Buttons -->

                    <div class="result-actions">


                        <a
                            href="units.html"
                            class="btn-result-primary"
                        >

                            <i class="bi bi-arrow-left me-1"></i>

                            Back to Units

                        </a>


                        <a
                            href="quiz.html"
                            class="btn-result-outline"
                        >

                            <i class="bi bi-arrow-counterclockwise me-1"></i>

                            Try Another Quiz
                        </a>

                    </div>

                </div>



                <!-- =====================================
                     ANSWER BREAKDOWN
                ====================================== -->

                <div class="answer-card">


                    <div class="answer-heading">

                        <div class="answer-heading-icon">

                            <i class="bi bi-list-check"></i>

                        </div>


                        <div>

                            <h5>
                                Answer Breakdown
                            </h5>

                            <p>
                                Review your answers and see the correct answers.
                            </p>

                        </div>

                    </div>



                    <!-- Question 01 -->

                    <div class="answer-item correct-answer">

                        <div class="answer-item-top">

                            <span class="answer-question-number">
                                Question 01
                            </span>

                            <span class="answer-correct">

                                <i class="bi bi-check-circle-fill me-1"></i>

                                Correct

                            </span>

                        </div>


                        <p class="answer-question">

                            Which of the following is a fundamental
                            base unit?

                        </p>


                        <div class="answer-choice">

                            <i class="bi bi-check-circle-fill"></i>

                            <span>
                                B) Ampere (A)
                            </span>

                        </div>

                    </div>



                    <!-- Question 02 -->

                    <div class="answer-item correct-answer">

                        <div class="answer-item-top">

                            <span class="answer-question-number">
                                Question 02
                            </span>

                            <span class="answer-correct">

                                <i class="bi bi-check-circle-fill me-1"></i>

                                Correct

                            </span>

                        </div>


                        <p class="answer-question">

                            What is the dimensional formula for force?

                        </p>


                        <div class="answer-choice">

                            <i class="bi bi-check-circle-fill"></i>

                            <span>
                                A) [M L T⁻²]
                            </span>

                        </div>

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