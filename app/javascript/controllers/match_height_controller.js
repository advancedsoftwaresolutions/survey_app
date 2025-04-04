// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define targets for the elements whose heights need to be matched.
  static targets = ["a", "b"];

  // Called when the controller is connected to the DOM.
  connect() {
    console.log("match-height controller connected"); // Log when the controller is connected.
    this.match(); // Match the heights of the target elements.
    window.addEventListener("resize", this.match); // Recalculate heights on window resize.
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    window.removeEventListener("resize", this.match); // Remove the resize event listener.
  }

  // Match the heights of the target elements.
  match = () => {
    console.log("Matching heights...", this.aTarget, this.bTarget); // Log the matching process.
    if (!this.hasATarget || !this.hasBTarget) return; // Exit if targets are not defined.

    // Calculate the maximum height between the two targets.
    const height = Math.max(
      this.aTarget.offsetHeight,
      this.bTarget.offsetHeight
    );

    // Set the minimum height of both targets to the calculated maximum height.
    this.aTarget.style.minHeight = `${height}px`;
    this.bTarget.style.minHeight = `${height}px`;
  };
}
