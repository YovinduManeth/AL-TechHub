-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 04, 2026 at 04:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `al_techhub`
--

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `lesson_number` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` text DEFAULT NULL,
  `video_path` varchar(255) DEFAULT NULL,
  `video_1080p_path` varchar(255) DEFAULT NULL,
  `video_720p_path` varchar(255) DEFAULT NULL,
  `video_480p_path` varchar(255) DEFAULT NULL,
  `video_360p_path` varchar(255) DEFAULT NULL,
  `audio_path` varchar(255) DEFAULT NULL,
  `duration_minutes` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `unit_id`, `lesson_number`, `title`, `description`, `video_path`, `video_1080p_path`, `video_720p_path`, `video_480p_path`, `video_360p_path`, `audio_path`, `duration_minutes`, `created_at`) VALUES
(1, 1, '1', 'Test Lesson', 'Test Description', 'uploads/videos/lesson_1788446393_426b56d4.mp4', 'uploads/videos/quality/lesson_1788446393_426b56d4_1080p.mp4', 'uploads/videos/quality/lesson_1788446393_426b56d4_720p.mp4', 'uploads/videos/quality/lesson_1788446393_426b56d4_480p.mp4', 'uploads/videos/quality/lesson_1788446393_426b56d4_360p.mp4', 'uploads/audios/lesson_1788446393_426b56d4.mp3', NULL, '2026-09-03 14:40:58'),
(2, 1, '2', 'Test Lesson 2', 'Test Description 2', 'uploads/videos/lesson_1788447505_6bae1346.mp4', 'uploads/videos/quality/lesson_1788447505_6bae1346_1080p.mp4', 'uploads/videos/quality/lesson_1788447505_6bae1346_720p.mp4', 'uploads/videos/quality/lesson_1788447505_6bae1346_480p.mp4', 'uploads/videos/quality/lesson_1788447505_6bae1346_360p.mp4', 'uploads/audios/lesson_1788447505_6bae1346.mp3', 1, '2026-09-03 15:02:13');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `past_papers`
--

CREATE TABLE `past_papers` (
  `paper_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `grade` enum('12','13') NOT NULL,
  `year` year(4) NOT NULL,
  `title` varchar(200) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `past_papers`
--

INSERT INTO `past_papers` (`paper_id`, `subject_id`, `grade`, `year`, `title`, `file_path`, `created_at`) VALUES
(1, 5, '12', '2023', '2023 agri paper', 'uploads/past_papers/paper_1787677993_c9d5f62d.pdf', '2026-08-25 17:13:13');

-- --------------------------------------------------------

--
-- Table structure for table `quizzes`
--

CREATE TABLE `quizzes` (
  `quiz_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `time_limit` int(11) DEFAULT 15,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quizzes`
--

INSERT INTO `quizzes` (`quiz_id`, `unit_id`, `title`, `time_limit`, `created_at`) VALUES
(1, 1, 'Unit 01 Assessment', 15, '2026-08-26 11:43:38');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempts`
--

CREATE TABLE `quiz_attempts` (
  `attempt_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_marks` int(11) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `correct_count` int(11) NOT NULL,
  `attempted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_attempts`
--

INSERT INTO `quiz_attempts` (`attempt_id`, `user_id`, `quiz_id`, `score`, `total_marks`, `percentage`, `correct_count`, `attempted_at`) VALUES
(1, 3, 1, 90, 100, 90.00, 9, '2026-08-26 13:11:31'),
(2, 3, 1, 90, 100, 90.00, 9, '2026-08-26 13:24:08'),
(3, 3, 1, 30, 100, 30.00, 3, '2026-08-26 13:24:37'),
(4, 3, 1, 100, 100, 100.00, 10, '2026-08-26 13:35:39'),
(5, 3, 1, 40, 100, 40.00, 4, '2026-08-26 13:37:35');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_attempt_answers`
--

CREATE TABLE `quiz_attempt_answers` (
  `answer_id` int(11) NOT NULL,
  `attempt_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `selected_answer` char(1) NOT NULL,
  `correct_answer` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_attempt_answers`
--

INSERT INTO `quiz_attempt_answers` (`answer_id`, `attempt_id`, `question_id`, `selected_answer`, `correct_answer`) VALUES
(1, 2, 3, 'C', 'C'),
(2, 2, 2, 'B', 'B'),
(3, 2, 5, 'B', 'B'),
(4, 2, 9, 'D', 'D'),
(5, 2, 1, 'D', 'B'),
(6, 2, 6, 'D', 'D'),
(7, 2, 8, 'B', 'B'),
(8, 2, 4, 'A', 'A'),
(9, 2, 10, 'A', 'A'),
(10, 2, 7, 'C', 'C'),
(11, 2, 3, 'C', 'C'),
(12, 2, 2, 'B', 'B'),
(13, 2, 5, 'B', 'B'),
(14, 2, 9, 'D', 'D'),
(15, 2, 1, 'D', 'B'),
(16, 2, 6, 'D', 'D'),
(17, 2, 8, 'B', 'B'),
(18, 2, 4, 'A', 'A'),
(19, 2, 10, 'A', 'A'),
(20, 2, 7, 'C', 'C'),
(21, 3, 6, 'A', 'D'),
(22, 3, 1, 'C', 'B'),
(23, 3, 3, 'A', 'C'),
(24, 3, 9, 'B', 'D'),
(25, 3, 7, 'A', 'C'),
(26, 3, 2, 'C', 'B'),
(27, 3, 5, 'B', 'B'),
(28, 3, 4, 'A', 'A'),
(29, 3, 10, 'B', 'A'),
(30, 3, 8, 'B', 'B'),
(31, 3, 6, 'A', 'D'),
(32, 3, 1, 'C', 'B'),
(33, 3, 3, 'A', 'C'),
(34, 3, 9, 'B', 'D'),
(35, 3, 7, 'A', 'C'),
(36, 3, 2, 'C', 'B'),
(37, 3, 5, 'B', 'B'),
(38, 3, 4, 'A', 'A'),
(39, 3, 10, 'B', 'A'),
(40, 3, 8, 'B', 'B'),
(41, 4, 10, 'A', 'A'),
(42, 4, 7, 'C', 'C'),
(43, 4, 1, 'B', 'B'),
(44, 4, 9, 'D', 'D'),
(45, 4, 2, 'B', 'B'),
(46, 4, 5, 'B', 'B'),
(47, 4, 6, 'D', 'D'),
(48, 4, 4, 'A', 'A'),
(49, 4, 8, 'B', 'B'),
(50, 4, 3, 'C', 'C'),
(51, 5, 8, 'B', 'B'),
(52, 5, 7, 'B', 'C'),
(53, 5, 1, 'C', 'B'),
(54, 5, 6, 'C', 'D'),
(55, 5, 2, 'C', 'B'),
(56, 5, 5, 'B', 'B'),
(57, 5, 10, 'B', 'A'),
(58, 5, 3, 'C', 'C'),
(59, 5, 4, 'A', 'A'),
(60, 5, 9, 'B', 'D');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `question_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `question_text` text NOT NULL,
  `option_a` varchar(500) NOT NULL,
  `option_b` varchar(500) NOT NULL,
  `option_c` varchar(500) NOT NULL,
  `option_d` varchar(500) NOT NULL,
  `correct_answer` enum('A','B','C','D') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`question_id`, `quiz_id`, `question_text`, `option_a`, `option_b`, `option_c`, `option_d`, `correct_answer`) VALUES
(1, 1, 'Which of the following is a fundamental SI base unit?', 'Newton (N)', 'Ampere (A)', 'Joule (J)', 'Watt (W)', 'B'),
(2, 1, 'Which physical quantity is measured in metres?', 'Mass', 'Length', 'Time', 'Temperature', 'B'),
(3, 1, 'Which SI unit is used to measure time?', 'Metre', 'Kilogram', 'Second', 'Ampere', 'C'),
(4, 1, 'Which instrument is commonly used to measure temperature?', 'Thermometer', 'Barometer', 'Ammeter', 'Ruler', 'A'),
(5, 1, 'What is the SI unit of mass?', 'Newton', 'Kilogram', 'Joule', 'Watt', 'B'),
(6, 1, 'Which quantity is a scalar quantity?', 'Force', 'Velocity', 'Displacement', 'Mass', 'D'),
(7, 1, 'What is the SI unit of electric current?', 'Volt', 'Ohm', 'Ampere', 'Coulomb', 'C'),
(8, 1, 'Which quantity is measured in seconds?', 'Length', 'Time', 'Mass', 'Force', 'B'),
(9, 1, 'Which of the following is a derived SI unit?', 'Metre', 'Kilogram', 'Second', 'Newton', 'D'),
(10, 1, 'What is the SI unit of energy?', 'Joule', 'Newton', 'Watt', 'Pascal', 'A');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `result_id` int(11) NOT NULL,
  `quiz_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `total_marks` int(11) NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `completed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `short_notes`
--

CREATE TABLE `short_notes` (
  `note_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `short_notes`
--

INSERT INTO `short_notes` (`note_id`, `unit_id`, `title`, `file_path`, `created_at`) VALUES
(1, 1, 'SI Base Units - Short Notes', 'uploads/notes/note_1787675216_e3b47dae.pdf', '2026-08-25 16:26:56');

-- --------------------------------------------------------

--
-- Table structure for table `student_progress`
--

CREATE TABLE `student_progress` (
  `progress_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `student_subjects`
--

CREATE TABLE `student_subjects` (
  `student_subject_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_subjects`
--

INSERT INTO `student_subjects` (`student_subject_id`, `user_id`, `subject_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 4),
(4, 2, 1),
(5, 2, 2),
(6, 2, 4),
(7, 3, 1),
(8, 3, 3),
(9, 3, 5),
(10, 4, 1),
(11, 4, 2),
(12, 4, 4),
(19, 7, 1),
(20, 7, 2),
(21, 7, 4);

-- --------------------------------------------------------

--
-- Table structure for table `student_unit_progress`
--

CREATE TABLE `student_unit_progress` (
  `progress_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_code` varchar(10) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `basket` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_code`, `subject_name`, `basket`) VALUES
(1, 'SFT', 'Science for Technology', 'Core'),
(2, 'ET', 'Engineering Technology', 'Basket 02'),
(3, 'BST', 'Bio Systems Technology', 'Basket 02'),
(4, 'ICT', 'Information & Communication Technology', 'Basket 03'),
(5, 'AGRI', 'Agricultural Science', 'Basket 03');

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `grade` enum('12','13') NOT NULL,
  `unit_number` int(11) NOT NULL,
  `unit_title` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_id`, `subject_id`, `grade`, `unit_number`, `unit_title`) VALUES
(1, 1, '12', 1, 'Fundamentals of Physics & Measurement'),
(2, 1, '12', 2, 'Principles of Electricity & Magnetism'),
(3, 1, '12', 3, 'Energy, Work & Power');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','admin') DEFAULT 'student',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `remember_token` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `full_name`, `email`, `username`, `password`, `role`, `created_at`, `remember_token`) VALUES
(1, 'test student', 'teststudent@gmail.com', 'teststudent01', '$2y$10$ZlZ5.jtmYjtKd/QLghyeLuPFZkDJTP6d0AOqtqexJfukBC1qu//eK', 'student', '2026-08-21 15:46:33', NULL),
(2, 'yovindumaneth', 'yovindu@gmail.com', 'yoviempire', '$2y$10$vImKJLqNx1enEKwIKZXQ/ufJSW5JczIDOFGMfDQ91dPFBjUpFyKTi', 'student', '2026-08-21 15:53:40', NULL),
(3, 'usertestfullname', 'testuser@gmail.com', 'user@test', '$2y$10$oHWRfoHZNX7CgMbNvFbQV.jjMKsTK86j7FvvQgVaInoeVgXLKmYta', 'student', '2026-08-25 16:24:38', '084a9c5b30d10c4fb1a0579b616e232a26debdc4081b5b2d95e932febf3c53b1'),
(4, 'yovi max bro', 'yovimaxbro@gmail.com', 'YoviMaxBro', '$2y$10$9ZgeuJ692FydJjVFJI2QOOVHjy/uPG0/ukYemC3LRY1tBFnVbKyXO', 'student', '2026-08-31 15:43:30', NULL),
(7, 'yovi', 'yovi@gmail.com', 'yovi12', '$2y$10$3rxVqiFq1DV71YD0AQ8sau4uN.Vmw6MD/0xSh1iwLKeWkVJev6h/y', 'student', '2026-09-04 09:16:55', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `past_papers`
--
ALTER TABLE `past_papers`
  ADD PRIMARY KEY (`paper_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD PRIMARY KEY (`quiz_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD PRIMARY KEY (`attempt_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quiz_attempt_answers`
--
ALTER TABLE `quiz_attempt_answers`
  ADD PRIMARY KEY (`answer_id`),
  ADD KEY `attempt_id` (`attempt_id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `quiz_id` (`quiz_id`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `quiz_id` (`quiz_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `short_notes`
--
ALTER TABLE `short_notes`
  ADD PRIMARY KEY (`note_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD UNIQUE KEY `user_lesson_unique` (`user_id`,`lesson_id`),
  ADD UNIQUE KEY `unique_user_lesson` (`user_id`,`lesson_id`),
  ADD KEY `lesson_id` (`lesson_id`);

--
-- Indexes for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD PRIMARY KEY (`student_subject_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`subject_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `student_unit_progress`
--
ALTER TABLE `student_unit_progress`
  ADD PRIMARY KEY (`progress_id`),
  ADD UNIQUE KEY `unique_student_unit` (`user_id`,`unit_id`),
  ADD KEY `unit_id` (`unit_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`),
  ADD KEY `subject_id` (`subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `past_papers`
--
ALTER TABLE `past_papers`
  MODIFY `paper_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quizzes`
--
ALTER TABLE `quizzes`
  MODIFY `quiz_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  MODIFY `attempt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `quiz_attempt_answers`
--
ALTER TABLE `quiz_attempt_answers`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `short_notes`
--
ALTER TABLE `short_notes`
  MODIFY `note_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `student_progress`
--
ALTER TABLE `student_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `student_subjects`
--
ALTER TABLE `student_subjects`
  MODIFY `student_subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `student_unit_progress`
--
ALTER TABLE `student_unit_progress`
  MODIFY `progress_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `lessons_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE;

--
-- Constraints for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD CONSTRAINT `password_resets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `past_papers`
--
ALTER TABLE `past_papers`
  ADD CONSTRAINT `past_papers_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `quizzes`
--
ALTER TABLE `quizzes`
  ADD CONSTRAINT `quizzes_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_attempts`
--
ALTER TABLE `quiz_attempts`
  ADD CONSTRAINT `quiz_attempts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_attempts_ibfk_2` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_attempt_answers`
--
ALTER TABLE `quiz_attempt_answers`
  ADD CONSTRAINT `quiz_attempt_answers_ibfk_1` FOREIGN KEY (`attempt_id`) REFERENCES `quiz_attempts` (`attempt_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_attempt_answers_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `quiz_questions` (`question_id`) ON DELETE CASCADE;

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `fk_quiz_questions_quiz` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_ibfk_1` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`quiz_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quiz_results_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `short_notes`
--
ALTER TABLE `short_notes`
  ADD CONSTRAINT `short_notes_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_progress`
--
ALTER TABLE `student_progress`
  ADD CONSTRAINT `student_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_progress_ibfk_2` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_subjects`
--
ALTER TABLE `student_subjects`
  ADD CONSTRAINT `student_subjects_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_subjects_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;

--
-- Constraints for table `student_unit_progress`
--
ALTER TABLE `student_unit_progress`
  ADD CONSTRAINT `student_unit_progress_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `student_unit_progress_ibfk_2` FOREIGN KEY (`unit_id`) REFERENCES `units` (`unit_id`) ON DELETE CASCADE;

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
