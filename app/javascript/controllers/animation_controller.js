import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { targetId: String };

  connect() {
    document.addEventListener(
      "turbo:before-stream-render",
      this.animate.bind(this)
    );
  }

  animate(event) {
    const stream = event.target;
    const content = document.getElementById(this.targetIdValue);

    if (stream.getAttribute("action") === "update" && content) {
      content.classList.remove("animate-soft-lift");
      void content.offsetWidth;
      content.classList.add("animate-soft-lift");
    }
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.animate);
  }
}
