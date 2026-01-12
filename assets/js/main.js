// INITIALIZE ANIMATIONS
AOS.init({
  duration: 1000,
  once: true,
});

// LOADER
window.addEventListener("load", () => {
  setTimeout(() => {
    document.getElementById("loader").style.opacity = "0";
    setTimeout(() => {
      document.getElementById("loader").style.display = "none";
    }, 500);
  }, 2000); // 2 secondes de faux chargement pour le style
});

// PARTICLES JS CONFIG
particlesJS("particles-js", {
  particles: {
    number: { value: 80, density: { enable: true, value_area: 800 } },
    color: { value: "#00ff41" },
    shape: { type: "circle" },
    opacity: { value: 0.5, random: true },
    size: { value: 3, random: true },
    line_linked: {
      enable: true,
      distance: 150,
      color: "#00f3ff",
      opacity: 0.2,
      width: 1,
    },
    move: { enable: true, speed: 2 },
  },
  interactivity: {
    detect_on: "canvas",
    events: {
      onhover: { enable: true, mode: "repulse" },
      onclick: { enable: true, mode: "push" },
    },
  },
});

// TERMINAL TYPEWRITER EFFECT
const terminalText = [
  "> Connecting to Stormshield SNS API...",
  "> Status: CONNECTED (200 OK)",
  "> Listening on port 514 (Syslog)...",
  "> Analyzing traffic flow...",
  "> [WARNING] Anomaly detected from IP 192.168.1.105",
  "> [AI ANALYSIS] Pattern match: Ransomware behavior (98%)",
  "> [ACTION] Blocking IP via Firewall Policy...",
  "> [SUCCESS] Threat neutralized in 0.02s.",
  "> System secure. Sleeping.",
];

let lineIndex = 0;
let charIndex = 0;
const typeSpeed = 30;
const terminalBody = document.getElementById("typewriter");

function typeWriter() {
  if (lineIndex < terminalText.length) {
    if (charIndex === 0) {
      terminalBody.innerHTML += "<div>";
    }

    const currentLine = terminalText[lineIndex];

    if (charIndex < currentLine.length) {
      terminalBody.lastElementChild.innerHTML += currentLine.charAt(charIndex);
      charIndex++;
      setTimeout(typeWriter, typeSpeed);
    } else {
      terminalBody.innerHTML += "</div>";
      lineIndex++;
      charIndex = 0;
      setTimeout(typeWriter, 500); // Pause entre les lignes
    }
  }
}

// Start typing when terminal is visible
const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      typeWriter();
      observer.unobserve(entry.target);
    }
  });
});
observer.observe(document.querySelector(".terminal-window"));
