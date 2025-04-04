// Import the Stimulus application instance from the application.js file.
import { application } from "controllers/application";

// Import the function to eagerly load Stimulus controllers.
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

// Eagerly load all controllers defined in the "controllers" directory.
// This automatically registers all controllers with the Stimulus application.
eagerLoadControllersFrom("controllers", application);
