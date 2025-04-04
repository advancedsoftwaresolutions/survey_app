import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { interval: Number };

  connect() {
    this.timer = setInterval(() => {
      const frame = this.element.querySelector("turbo-frame");
      if (frame) frame.reload();
    }, this.intervalValue || 10000);
  }

  disconnect() {
    clearInterval(this.timer);
  }
}
