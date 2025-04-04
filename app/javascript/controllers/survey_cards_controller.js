import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static values = {
    refreshInterval: Number
  }

  connect() {
    this.timer = setInterval(() => this.refresh(), this.refreshIntervalValue * 1000 || 10000)
  }

  disconnect() {
    clearInterval(this.timer)
  }

  refresh() {
    fetch("/surveys/cards", {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
      .then(response => {
        if (!response.ok) throw new Error("Failed to fetch survey cards")
        return response.text()
      })
      .then(html => {
        Turbo.renderStreamMessage(html)

        const now = new Date()
        const timestamp = now.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })

        // Update the container badge
        const containerBadge = document.getElementById("last-updated-badge")
        if (containerBadge) {
          containerBadge.classList.remove("text-danger")
          containerBadge.classList.add("text-success")
          containerBadge.setAttribute("title", `Last updated at ${timestamp}`)
          containerBadge.innerHTML = `<span class="dot bg-success"></span> Live`

          const tooltip = bootstrap?.Tooltip.getOrCreateInstance(containerBadge)
          tooltip?.show()
        }

        // Add animation to the card container
        const container = this.element
        container.classList.remove("animate-soft-lift")
        void container.offsetWidth
        container.classList.add("animate-soft-lift")
      })
      .catch(() => {
        const containerBadge = document.getElementById("last-updated-badge")
        if (containerBadge) {
          containerBadge.classList.remove("text-success")
          containerBadge.classList.add("text-danger")
          containerBadge.setAttribute("title", `Last update failed`)
          containerBadge.innerHTML = `<span class="dot bg-danger"></span> Error`
        }
      })
  }
}
