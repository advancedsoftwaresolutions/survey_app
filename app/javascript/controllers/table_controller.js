// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Define targets for table rows and pagination container.
  static targets = ["row", "pagination"];

  // Called when the controller is connected to the DOM.
  connect() {
    this.perPage = 5; // Number of rows to display per page.
    this.currentPage = 1; // Initialize the current page to the first page.
    this.update(); // Update the table display and pagination.
  }

  // Update the table rows and pagination based on the current page.
  update() {
    const rows = this.rowTargets; // Get all row targets.
    const totalPages = Math.ceil(rows.length / this.perPage); // Calculate the total number of pages.

    // Show only the rows for the current page.
    rows.forEach((row, index) => {
      const show =
        index >= (this.currentPage - 1) * this.perPage &&
        index < this.currentPage * this.perPage; // Determine if the row should be visible.
      row.classList.toggle("d-none", !show); // Hide or show the row based on the condition.
    });

    this.updatePagination(totalPages); // Update the pagination controls.
  }

  // Update the pagination controls based on the total number of pages.
  updatePagination(totalPages) {
    const container = this.paginationTarget; // Get the pagination container element.
    container.innerHTML = ""; // Clear the existing pagination controls.

    // Create pagination buttons for each page.
    for (let i = 1; i <= totalPages; i++) {
      const li = document.createElement("li"); // Create a list item for the pagination button.
      li.className = `custom-page-item ${i === this.currentPage
        ? "active"
        : ""}`; // Add "active" class for the current page.

      const button = document.createElement("button"); // Create a button for the page.
      button.className = "custom-page-link"; // Add a class for styling.
      button.textContent = i; // Set the button text to the page number.
      button.type = "button"; // Set the button type.
      button.addEventListener("click", () => {
        this.currentPage = i; // Update the current page when the button is clicked.
        this.update(); // Refresh the table and pagination.
      });

      li.appendChild(button); // Add the button to the list item.
      container.appendChild(li); // Add the list item to the pagination container.
    }
  }
}
