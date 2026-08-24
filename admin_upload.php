<?php

require_once "php/db.php";
require_once "php/ffmpeg.php";


// ==========================================
// ONLY ALLOW POST REQUEST
// ==========================================

if ($_SERVER["REQUEST_METHOD"] !== "POST") {

    header("Location: admin-upload.php");
    exit();

}


// ==========================================
// GET FORM DATA
// ==========================================

$resource_type = $_POST["resource_type"] ?? "";
$unit_id = $_POST["unit_id"] ?? "";
$title = trim($_POST["title"] ?? "");
$description = trim($_POST["description"] ?? "");


// ==========================================
// CHECK RESOURCE TYPE
// ==========================================

if ($resource_type !== "lesson") {

    die("Currently only Video Lesson uploads are supported.");

}


// ==========================================
// CHECK REQUIRED DATA
// ==========================================

if (
    empty($unit_id) ||
    empty($title) ||
    !isset($_FILES["video"])
) {

    die("Please complete all required fields.");

}


// ==========================================
// CHECK UPLOADED FILE
// ==========================================

if ($_FILES["video"]["error"] !== UPLOAD_ERR_OK) {

    die("Video upload failed.");

}


$video_file = $_FILES["video"];


// ==========================================
// CHECK FILE TYPE
// ==========================================

$file_extension = strtolower(
    pathinfo($video_file["name"], PATHINFO_EXTENSION)
);

if ($file_extension !== "mp4") {

    die("Only MP4 video files are allowed.");

}


// ==========================================
// CREATE UNIQUE FILE NAME
// ==========================================

$unique_name =
    "lesson_" .
    time() .
    "_" .
    bin2hex(random_bytes(4)) .
    ".mp4";


// ==========================================
// UPLOAD DIRECTORIES
// ==========================================

$video_directory = "uploads/videos/";
$audio_directory = "uploads/audios/";


// Create directories if they don't exist

if (!is_dir($video_directory)) {

    mkdir($video_directory, 0777, true);

}

if (!is_dir($audio_directory)) {

    mkdir($audio_directory, 0777, true);

}


// ==========================================
// FILE PATHS
// ==========================================

$video_path = $video_directory . $unique_name;

$audio_name =
    pathinfo($unique_name, PATHINFO_FILENAME) .
    ".mp3";

$audio_path = $audio_directory . $audio_name;


// ==========================================
// MOVE UPLOADED VIDEO
// ==========================================

if (!move_uploaded_file(
    $video_file["tmp_name"],
    $video_path
)) {

    die("Failed to save uploaded video.");

}


// ==========================================
// GENERATE AUDIO USING FFMPEG
// ==========================================

$audio_result = generateAudioFromVideo(
    $video_path,
    $audio_path
);


// ==========================================
// CHECK AUDIO GENERATION
// ==========================================

if (!$audio_result["success"]) {

    // Remove uploaded video if audio generation fails

    if (file_exists($video_path)) {

        unlink($video_path);

    }

    echo "<h2>Audio generation failed.</h2>";

    echo "<pre>";

    print_r($audio_result);

    echo "</pre>";

    exit();

}


// ==========================================
// GET VIDEO DURATION
// ==========================================

// For now we will leave duration as NULL.

$duration_minutes = null;


// ==========================================
// GET NEXT LESSON NUMBER
// ==========================================

$sql = "SELECT COUNT(*) AS lesson_count
        FROM lessons
        WHERE unit_id = ?";

$stmt = $conn->prepare($sql);

$stmt->bind_param("i", $unit_id);

$stmt->execute();

$result = $stmt->get_result();

$row = $result->fetch_assoc();

$stmt->close();


$lesson_number =
    "1." . ($row["lesson_count"] + 1);


// ==========================================
// INSERT LESSON INTO DATABASE
// ==========================================

$sql = "INSERT INTO lessons
        (
            unit_id,
            lesson_number,
            title,
            description,
            video_path,
            audio_path,
            duration_minutes
        )
        VALUES (?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);

$stmt->bind_param(
    "isssssi",
    $unit_id,
    $lesson_number,
    $title,
    $description,
    $video_path,
    $audio_path,
    $duration_minutes
);


if (!$stmt->execute()) {

    // Remove files if database insertion fails

    if (file_exists($video_path)) {
        unlink($video_path);
    }

    if (file_exists($audio_path)) {
        unlink($audio_path);
    }

    die(
        "Database error: " .
        $stmt->error
    );

}

$stmt->close();


// ==========================================
// SUCCESS
// ==========================================

echo "<h2>Lesson uploaded successfully!</h2>";

echo "<p>Video: " .
     htmlspecialchars($video_path) .
     "</p>";

echo "<p>Audio: " .
     htmlspecialchars($audio_path) .
     "</p>";

echo "<p>Lesson Number: " .
     htmlspecialchars($lesson_number) .
     "</p>";

echo "<p>FFmpeg successfully generated the audio.</p>";

?>