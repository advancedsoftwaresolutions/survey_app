document.addEventListener("turbo:load", () => {
    const overlay = document.getElementById("welcome-overlay");
    const replayBtn = document.getElementById("replay-intro");
  
    if (sessionStorage.getItem("welcomeSeen")) {
      overlay?.classList.add("d-none");
    } else {
      setTimeout(() => {
        overlay?.classList.add("fade-out-blur");
  
        // Wait for fade animation before hiding
        setTimeout(() => {
          overlay?.classList.add("d-none");
        }, 700); // ← must match CSS transition duration
  
        sessionStorage.setItem("welcomeSeen", "true");
      }, 3000);
    }
  
    replayBtn?.addEventListener("click", () => {
      sessionStorage.removeItem("welcomeSeen");
      overlay?.classList.remove("d-none");
  
      // Trigger reflow to re-enable transition
      void overlay?.offsetWidth;
  
      overlay?.classList.remove("fade-out-blur");
  
      setTimeout(() => {
        overlay?.classList.add("fade-out-blur");
  
        setTimeout(() => {
          overlay?.classList.add("d-none");
        }, 700);
  
        sessionStorage.setItem("welcomeSeen", "true");
      }, 3000);
    });
  });
  