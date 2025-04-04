// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Method to close the Bootstrap navbar collapse menu.
  close() {
    // Get the Bootstrap Collapse instance associated with this element.
    const collapse = bootstrap.Collapse.getInstance(this.element);

    // Check if the collapse menu is currently shown.
    if (collapse && collapse._isShown) {
      collapse.hide(); // Hide the collapse menu.
    }
  }
}
