// ==========================================
// Password Visibility Toggle
// ==========================================

function setupPasswordToggle(toggleId, passwordId, iconId) {

    const toggleButton = document.getElementById(toggleId);
    const passwordInput = document.getElementById(passwordId);
    const eyeIcon = document.getElementById(iconId);

    // Stop if elements do not exist on this page
    if (!toggleButton || !passwordInput || !eyeIcon) {
        return;
    }

    toggleButton.addEventListener("click", function () {

        if (passwordInput.type === "password") {

            passwordInput.type = "text";

            eyeIcon.classList.remove("bi-eye");
            eyeIcon.classList.add("bi-eye-slash");

            toggleButton.setAttribute(
                "aria-label",
                "Hide password"
            );

        } else {

            passwordInput.type = "password";

            eyeIcon.classList.remove("bi-eye-slash");
            eyeIcon.classList.add("bi-eye");

            toggleButton.setAttribute(
                "aria-label",
                "Show password"
            );
        }

    });
}


// ==========================================
// Registration Password Toggle
// ==========================================

setupPasswordToggle(
    "togglePassword",
    "password",
    "eyeIcon"
);

setupPasswordToggle(
    "toggleConfirmPassword",
    "confirmPassword",
    "confirmEyeIcon"
);


// ==========================================
// Password Match Validation
// ==========================================

const registerForm = document.getElementById("registerForm");
const password = document.getElementById("password");
const confirmPassword = document.getElementById("confirmPassword");

if (registerForm && password && confirmPassword) {

    registerForm.addEventListener("submit", function (event) {

        if (password.value !== confirmPassword.value) {

            event.preventDefault();

            confirmPassword.classList.add("is-invalid");

            alert("Passwords do not match. Please check your password.");

        } else {

            confirmPassword.classList.remove("is-invalid");

        }

    });

}




// ==========================================
// Smooth Scrolling
// ==========================================

document.addEventListener("DOMContentLoaded", function () {

    const smoothLinks = document.querySelectorAll('a[href^="#"]');

    smoothLinks.forEach(function (link) {

        link.addEventListener("click", function (event) {

            const targetId = this.getAttribute("href");

            if (targetId === "#") {
                return;
            }

            const target = document.querySelector(targetId);

            if (target) {

                event.preventDefault();

                target.scrollIntoView({
                    behavior: "smooth",
                    block: "start"
                });

            }

        });

    });

});


// ==========================================
// Data-Saver Mode
// ==========================================

function setupDataSaverMode() {

    const toggle = document.getElementById("dataModeToggle");
    const videoContainer = document.getElementById("videoContainer");
    const audioContainer = document.getElementById("audioContainer");

    const videoPlayer = document.getElementById("videoPlayer");
    const audioPlayer = document.getElementById("audioPlayer");

    // Stop if this is not the lesson page
    if (
        !toggle ||
        !videoContainer ||
        !audioContainer ||
        !videoPlayer ||
        !audioPlayer
    ) {
        return;
    }

    toggle.addEventListener("change", function () {

        if (toggle.checked) {

            // Stop video
            videoPlayer.pause();

            // Hide video
            videoContainer.style.display = "none";

            // Show audio
            audioContainer.style.display = "block";

        } else {

            // Stop audio
            audioPlayer.pause();

            // Hide audio
            audioContainer.style.display = "none";

            // Show video
            videoContainer.style.display = "block";

        }

    });

}


// Start Data-Saver Mode
setupDataSaverMode();



// ==========================================
// Video Quality Selector
// ==========================================

function setupVideoQuality() {

    const qualitySelector =
        document.getElementById("videoQuality");

    const videoPlayer =
        document.getElementById("videoPlayer");

    const videoSource =
        document.getElementById("videoSource");


    // Stop if this is not the lesson page
    if (
        !qualitySelector ||
        !videoPlayer ||
        !videoSource
    ) {
        return;
    }


    qualitySelector.addEventListener("change", function () {

        const selectedQuality =
            qualitySelector.value;


        // Remember current playback position
        const currentTime =
            videoPlayer.currentTime;


        // Change video source
        videoSource.src =
            "uploads/videos/sample_lesson_" +
            selectedQuality +
            ".mp4";


        // Reload video with new quality
        videoPlayer.load();


        // Restore playback position
        videoPlayer.currentTime =
            currentTime;


        // Continue playing if video was playing
        videoPlayer.play().catch(function () {

            // Browser may block automatic playback.
            // User can press play manually.

        });

    });

}


// Start Video Quality Selector
setupVideoQuality();