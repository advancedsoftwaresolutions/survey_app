// app/javascript/controllers/survey_card_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    id: Number,
    refreshInterval: Number
  };

  connect() {
    this.startPolling();
  }

  disconnect() {
    clearInterval(this.timer);
  }

  startPolling() {
    if (!this.hasRefreshIntervalValue || !this.hasIdValue) return;

    this.timer = setInterval(
      () => this.refresh(),
      this.refreshIntervalValue * 1000
    );
  }

  refresh() {
    const badge = document.getElementById(`live-badge-${this.idValue}`);

    fetch(`/surveys/${this.idValue}/card`, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
      .then(response => {
        if (!response.ok) throw new Error("Network error");
        return response.text();
      })
      .then(html => {
        Turbo.renderStreamMessage(html);

        if (badge) {
          badge.classList.remove("text-danger");
          badge.classList.add("text-success");

          const now = new Date();
          const timestamp = now.toLocaleTimeString([], {
            hour: "2-digit",
            minute: "2-digit"
          });

          badge.setAttribute("title", `Last updated at ${timestamp}`);

          // Re-enable Bootstrap tooltip
          const tooltip = bootstrap.Tooltip.getOrCreateInstance(badge);
          tooltip.show();
        }
      })
      .catch(() => {
        if (badge) {
          badge.classList.remove("text-success");
          badge.classList.add("text-danger");
          badge.setAttribute("title", `Last update failed`);
        }
      });
  }
}
