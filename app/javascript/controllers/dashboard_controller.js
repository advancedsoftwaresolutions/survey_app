// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define a static value for the refresh interval (in seconds) that can be set in the HTML.
  static values = {
    refreshInterval: Number
  };

  // Called when the controller is connected to the DOM.
  connect() {
    this.startPolling(); // Start the polling process to refresh the dashboard.
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    clearInterval(this.timer); // Clear the polling timer to stop refreshing.
  }

  // Start the polling process by setting up a timer.
  startPolling() {
    this.timer = setInterval(
      () => this.refresh(), // Call the refresh method at regular intervals.
      this.refreshIntervalValue * 1000 // Convert the interval from seconds to milliseconds.
    );
  }

  // Perform the refresh operation by fetching the current page and updating the content.
  refresh() {
    fetch(window.location.href, {
      headers: { Accept: "text/vnd.turbo-stream.html" } // Request Turbo Stream format.
    })
      .then(response => response.text()) // Parse the response as text.
      .then(html => Turbo.renderStreamMessage(html)); // Update the page using Turbo Stream.
  }
}
