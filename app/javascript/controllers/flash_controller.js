// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Called when the controller is connected to the DOM.
  connect() {
    // Wait for the initial frame (after the fade-in animation starts).
    requestAnimationFrame(() => {
      // Set a timeout to add the "fade-out" class after 5 seconds.
      this.fadeTimeout = setTimeout(() => {
        this.element.classList.add("fade-out"); // Trigger fade-out animation.
      }, 5000); // Show the flash message for 5 seconds.
    });

    // Listen for the end of the fade-out animation.
    this.element.addEventListener("animationend", e => {
      if (e.animationName === "fadeOutSlide") {
        this.element.remove(); // Remove the element from the DOM after the animation ends.
      }
    });
  }

  // Manually remove the flash message element from the DOM.
  remove() {
    this.element.remove();
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    clearTimeout(this.fadeTimeout); // Clear the timeout to prevent memory leaks.
  }
}
