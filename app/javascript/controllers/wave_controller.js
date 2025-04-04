// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define targets for the top and bottom elements that will move with the scroll effect.
  static targets = ["top", "bottom"];

  // Called when the controller is connected to the DOM.
  connect() {
    this.update = this.update.bind(this); // Bind the update method to the current instance.
    window.addEventListener("scroll", this.update); // Add a scroll event listener to the window.
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    window.removeEventListener("scroll", this.update); // Remove the scroll event listener.
  }

  // Update the position of the top and bottom targets based on the scroll position.
  update() {
    const scrollY = window.scrollY; // Get the current vertical scroll position.

    if (this.hasTopTarget) {
      // Apply a downward translation effect to the top target based on the scroll position.
      this.topTarget.style.transform = `translateY(${scrollY * 0.1}px)`;
    }

    if (this.hasBottomTarget) {
      // Apply an upward translation effect to the bottom target based on the scroll position.
      this.bottomTarget.style.transform = `translateY(${-scrollY * 0.1}px)`;
    }
  }
}
