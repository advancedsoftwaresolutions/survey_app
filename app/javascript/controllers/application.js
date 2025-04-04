// Import the Stimulus Application class from the Hotwired Stimulus library.
import { Application } from "@hotwired/stimulus";

// Initialize and start the Stimulus application.
const application = Application.start();

// Configure Stimulus development experience.
// Set debug mode to false to disable detailed logs in the console.
application.debug = false;

// Expose the Stimulus application globally for debugging purposes.
window.Stimulus = application;

// Export the Stimulus application instance for use in other modules.
export { application };
