// Import the base Controller class from the Stimulus library.
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  // Method to copy the current page URL to the clipboard.
  copyLink() {
    const url = window.location.href; // Get the current page URL.
    navigator.clipboard
      .writeText(url) // Write the URL to the clipboard.
      .then(() => {
        alert("Link copied to clipboard!"); // Show success message.
      })
      .catch(err => {
        console.error("Failed to copy:", err); // Log any errors.
      });
  }

  // Method to export table data as a CSV file.
  exportCSV() {
    // Get all rows from the table body.
    const rows = Array.from(document.querySelectorAll("table tbody tr"));
    if (rows.length === 0) return; // Exit if there are no rows.

    // Get table headers from the table head.
    const headers = Array.from(
      document.querySelectorAll("table thead th")
    ).map(th => th.textContent.trim()); // Extract and trim header text.

    // Extract data from each table row.
    const data = rows.map(row =>
      Array.from(row.querySelectorAll("td")).map(td => td.textContent.trim())
    );

    // Combine headers and data into a CSV string.
    const csv = [headers, ...data].map(e => e.join(",")).join("\n");

    // Create a Blob object for the CSV data.
    const blob = new Blob([csv], { type: "text/csv" });

    // Create a temporary download link for the CSV file.
    const url = window.URL.createObjectURL(blob);
    const link = document.createElement("a");
    link.href = url;
    link.download = "survey_responses.csv"; // Set the file name.
    link.click(); // Trigger the download.
    window.URL.revokeObjectURL(url); // Revoke the object URL to free memory.
  }

  // Method to share the current page using the Web Share API.
  share() {
    if (navigator.share) {
      // Use the Web Share API if supported.
      navigator.share({
        title: document.title, // Set the title of the shared content.
        url: window.location.href // Set the URL to share.
      });
    } else {
      // Show an alert if the browser does not support the Web Share API.
      alert("Sharing is not supported on this browser.");
    }
  }
}
