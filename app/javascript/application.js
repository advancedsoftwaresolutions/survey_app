// Import necessary libraries and modules for the application.
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"; // Turbo for faster navigation without full page reloads.
import "controllers"; // Import Stimulus controllers.
import "bootstrap"; // Bootstrap for styling and components.
import "chartkick"; // Chartkick for rendering charts.
import "Chart.bundle"; // Chart.js bundle for advanced charting features.
import { Application } from "@hotwired/stimulus"; // Stimulus framework for JavaScript controllers.

// Import custom Stimulus controllers.
import AutorefreshController from "./controllers/autorefresh_controller";
import FlashController from "./controllers/flash_controller";
import TableController from "./controllers/table_controller";
import BlurInController from "./controllers/blur_in_controller";
import NavbarController from "./controllers/navbar_controller";
import ShareController from "./controllers/share_controller";
import SurveyCardsController from "./controllers/survey_cards_controller";
import "./welcome_overlay";

// Initialize Stimulus application and register custom controllers.
window.Stimulus = Application.start();
Stimulus.register("autorefresh", AutorefreshController); // Controller for auto-refreshing content.
Stimulus.register("flash", FlashController); // Controller for flash messages.
Stimulus.register("table", TableController); // Controller for table interactions.
Stimulus.register("blur-in", BlurInController); // Controller for blur-in animations.
Stimulus.register("navbar", NavbarController); // Controller for navbar interactions.
Stimulus.register("share", ShareController); // Controller for sharing functionality.
Stimulus.register("survey-cards", SurveyCardsController);

// Add event listener for Turbo's page load event to animate percentage elements.
document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".percentage[data-percentage]").forEach(el => {
    const target = parseInt(el.dataset.percentage); // Target percentage value.
    let current = 0; // Start animation from 0.

    // Function to incrementally update the percentage text.
    const step = () => {
      current += 1; // Increment current percentage.
      el.textContent = `${current}%`; // Update element text.
      if (current < target) {
        requestAnimationFrame(step); // Continue animation until target is reached.
      } else {
        el.textContent = `${target}%`; // Ensure final value matches the target.
      }
    };

    requestAnimationFrame(step); // Start the animation.
  });
});

// Add event listener for Turbo's page load event to animate progress bars.
document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".progress-bar[data-target]").forEach(bar => {
    const target = parseInt(bar.dataset.target); // Target width percentage for the progress bar.
    const span = bar.querySelector(".progress-text"); // Text element inside the progress bar.

    // Animate the width of the progress bar with a small delay to trigger CSS transitions.
    setTimeout(() => {
      bar.style.width = `${target}%`;
    }, 100);

    // Animate the counting number inside the progress bar.
    let current = 0; // Start counting from 0.
    const step = () => {
      current += 1; // Increment current count.
      if (span) span.textContent = current; // Update the text inside the progress bar.
      if (current < target) {
        requestAnimationFrame(step); // Continue animation until target is reached.
      } else {
        if (span) span.textContent = target; // Ensure final value matches the target.
      }
    };
    requestAnimationFrame(step); // Start the animation.
  });
});

document.addEventListener("turbo:before-render", () => {
  document.body.classList.add("page-slide-out");
});

document.addEventListener("turbo:render", () => {
  document.body.classList.remove("page-slide-out");
  document.body.classList.add("page-slide-in");

  setTimeout(() => {
    document.body.classList.remove("page-slide-in");
  }, 300); // match animation duration
});
