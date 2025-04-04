// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define a static value for the delay (in milliseconds) that can be set in the HTML.
  static values = { delay: Number };

  // Called when the controller is connected to the DOM.
  connect() {
    // Create an IntersectionObserver to observe when the element enters or leaves the viewport.
    this.observer = new IntersectionObserver(
      entries => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // When the element is visible in the viewport, apply the "animate-in" class
            // after the specified delay and remove the "animate-out" class.
            setTimeout(() => {
              this.element.classList.remove("animate-out");
              this.element.classList.add("animate-in");
            }, this.delayValue || 0); // Use the delay value or default to 0.
          } else {
            // When the element is not visible in the viewport, apply the "animate-out" class
            // and remove the "animate-in" class.
            this.element.classList.remove("animate-in");
            this.element.classList.add("animate-out");
          }
        });
      },
      { threshold: 0.2 } // Trigger when 20% of the element is visible.
    );

    // Start observing the element.
    this.observer.observe(this.element);
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    // Stop observing the element to clean up resources.
    this.observer.disconnect();
  }
}
