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

    const toggle =
        document.getElementById("dataModeToggle");

    const videoContainer =
        document.getElementById("videoContainer");

    const audioContainer =
        document.getElementById("audioContainer");

    const videoQualityBox =
        document.querySelector(".video-quality-box");

    const videoPlayer =
        document.getElementById("videoPlayer");

    const audioPlayer =
        document.getElementById("audioPlayer");

    const audioSource = audioPlayer
        ? audioPlayer.querySelector("source")
        : null;


    // Stop if this is not the lesson page
    if (
        !toggle ||
        !videoContainer ||
        !audioContainer ||
        !videoQualityBox ||
        !videoPlayer ||
        !audioPlayer ||
        !audioSource
    ) {
        return;
    }


    toggle.addEventListener("change", function () {

        // ==========================================
        // DATA-SAVER ON
        // ==========================================

        if (toggle.checked) {

            // Stop video
            videoPlayer.pause();

            // Hide video
            videoContainer.style.display = "none";

            // Hide video quality selector
            videoQualityBox.style.display = "none";


            // Get audio source
            const audioPath =
                audioSource.getAttribute("src");

            console.log(
                "Data-Saver audio path:",
                audioPath
            );


            // Make sure an audio file exists
            if (
                !audioPath ||
                audioPath.trim() === ""
            ) {

                alert(
                    "No audio file is available for this lesson."
                );

                toggle.checked = false;

                videoContainer.style.display = "block";

                videoQualityBox.style.display = "flex";

                return;

            }


            // Reload audio source
            audioPlayer.load();


            // Show audio player
            audioContainer.style.display = "block";

        }


        // ==========================================
        // DATA-SAVER OFF
        // ==========================================

        else {

            // Stop audio
            audioPlayer.pause();

            // Hide audio
            audioContainer.style.display = "none";

            // Show video
            videoContainer.style.display = "block";

            // Show video quality selector
            videoQualityBox.style.display = "flex";

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



// ==========================================
// REGISTRATION SUCCESS MESSAGE
// ==========================================

const urlParams = new URLSearchParams(window.location.search);

if (urlParams.get("registered") === "success") {

    const registrationMessage =
        document.getElementById("registrationMessage");

    if (registrationMessage) {

        registrationMessage.classList.remove("d-none");
        registrationMessage.classList.add("d-flex");

    }

}



// ==========================================
// LOGIN ERROR MESSAGE
// ==========================================

const loginUrlParams = new URLSearchParams(window.location.search);

if (loginUrlParams.get("error") === "invalid") {

    const loginErrorMessage =
        document.getElementById("loginErrorMessage");

    if (loginErrorMessage) {

        loginErrorMessage.classList.remove("d-none");
        loginErrorMessage.classList.add("d-flex");

    }

    window.history.replaceState(
        {},
        document.title,
        window.location.pathname
    );

}


// ==========================================
// Global Day / Night Mode
// ==========================================

function setupThemeMode() {

    const modeButton =
        document.getElementById("themeToggle");

    const modeIcon =
        document.getElementById("themeIcon");


    // Stop if theme button does not exist
    if (!modeButton || !modeIcon) {
        return;
    }


    // ==========================================
    // Load Saved Theme
    // ==========================================

    const savedTheme =
        localStorage.getItem("theme");


    if (savedTheme === "dark") {

        document.body.classList.add("dark-mode");

        modeIcon.classList.remove("bi-moon");
        modeIcon.classList.add("bi-sun");

        modeButton.setAttribute(
            "aria-label",
            "Switch to day mode"
        );

        modeButton.setAttribute(
            "title",
            "Switch to day mode"
        );

    }


    // ==========================================
    // Toggle Theme
    // ==========================================

    modeButton.addEventListener("click", function () {

        document.body.classList.toggle("dark-mode");


        const isDarkMode =
            document.body.classList.contains("dark-mode");


        if (isDarkMode) {

            localStorage.setItem(
                "theme",
                "dark"
            );


            modeIcon.classList.remove(
                "bi-moon"
            );

            modeIcon.classList.add(
                "bi-sun"
            );


            modeButton.setAttribute(
                "aria-label",
                "Switch to day mode"
            );

            modeButton.setAttribute(
                "title",
                "Switch to day mode"
            );

        } else {

            localStorage.setItem(
                "theme",
                "light"
            );


            modeIcon.classList.remove(
                "bi-sun"
            );

            modeIcon.classList.add(
                "bi-moon"
            );


            modeButton.setAttribute(
                "aria-label",
                "Switch to night mode"
            );

            modeButton.setAttribute(
                "title",
                "Switch to night mode"
            );

        }

    });

}


// Start Theme Mode
document.addEventListener(
    "DOMContentLoaded",
    setupThemeMode
);