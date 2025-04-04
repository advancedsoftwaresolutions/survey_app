// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus"

// Define and export the AutorefreshController class.
export default class extends Controller {
  // Define a static value for the interval (in seconds) that can be set in the HTML.
  static values = {
    interval: Number
  }

  // Called when the controller is connected to the DOM.
  connect() {
    this.start() // Start the auto-refresh process.
  }

  // Called when the controller is disconnected from the DOM.
  disconnect() {
    this.stop() // Stop the auto-refresh process.
  }

  // Start the auto-refresh process by setting up a timer.
  start() {
    this.timer = setInterval(() => this.refresh(), this.intervalValue * 1000) // Refresh at the specified interval.
  }

  // Stop the auto-refresh process by clearing the timer.
  stop() {
    clearInterval(this.timer) // Clear the interval timer.
  }

  // Perform the refresh operation by fetching the current page and updating the content.
  refresh() {
    const spinner = document.getElementById("auto-refresh-spinner") // Get the spinner element.
    spinner?.classList.add("active") // Show the spinner while refreshing.
    const spinner2 = document.getElementById("auto-refresh-spinner-2") // Get the spinner element.
    spinner2?.classList.add("active") // Show the spinner while refreshing.

    // Fetch the current page with Turbo Stream headers.
    fetch(window.location.href, {
      headers: { Accept: "text/vnd.turbo-stream.html" } // Request Turbo Stream format.
    })
    .then(response => response.text()) // Parse the response as text.
    .then(html => {
      Turbo.renderStreamMessage(html) // Update the page using Turbo Stream.
      spinner?.classList.remove("active") // Hide the spinner after refreshing.
    })
  }
}