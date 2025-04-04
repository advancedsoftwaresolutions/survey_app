layout: post
title: "Building This App"
date: 2025-04-03 12:00:00 -0000
categories: BUILD DESIGN

# Building SurveyApp: A Lightweight, Component-Driven Survey App

As an engineer passionate about clean architecture, design systems, and minimal yet powerful tooling, I built **Rapid Fire Reports** — a simple yes/no survey app — to explore what it means to create a delightful, scalable Rails experience with just enough JavaScript and a focus on developer experience.

This post outlines the motivations, tradeoffs, and lessons behind the app’s design.

---

## ✨ The Goal

I wanted to build an app that:

- Allows users to create and respond to yes/no surveys — no login required
- Is polished, mobile-first, and responsive
- Uses **Rails 7 + ViewComponent + Stimulus** for a modern, component-based stack
- Has dark mode, animations, and a touch of UI personality
- Is fully containerized with **Docker** for easy onboarding
- Can serve as both a portfolio piece and a real tool

---

## 🧩 Architecture Decisions

### 1. **Rails + ViewComponent + Stimulus**
I leaned heavily into **Hotwire** principles but kept the JS light using Stimulus. For structure, I adopted **ViewComponent** to modularize the UI (e.g., SurveyCardComponent, FlashComponent, GradientWaveComponent). This made it easy to manage layout changes and animate transitions cleanly.

### 2. **SCSS System**
The SCSS structure is organized by `base/`, `components/`, and `layout/`, with token-based theming in `_variables.scss` and `_themes.scss`. This makes it extremely easy to:

- Add dark/light modes
- Enable glassmorphism effects
- Tweak the design with one-line changes

### 3. **Dockerized from Day 1**
Zero local Ruby/Node setup. All development happens inside Docker, so anyone can clone, build, and run the app with:
```bash
docker-compose up --build
```
This makes onboarding a breeze.

---

## ⚖️ Tradeoffs

### ✅ What I kept
- ViewComponent for UI encapsulation
- Stimulus for interactivity without over-engineering
- SQLite for simplicity (local-first development)

### 🚫 What I skipped
- User accounts — surveys are anonymous
- Admin dashboards — out of scope for this version
- Full client-side frameworks (React/Vue) — I wanted to prove that modern Rails + Stimulus is *enough*

---

## 🎨 UI and UX Polish

- Responsive layout with Bootstrap 5
- Theme switcher with smooth transitions and local storage
- Animated radial charts to replace boring pie graphs
- Animated SVG wave backgrounds that react to scroll
- Auto-expiring toast alerts with Stimulus

All components are previewed and testable in isolation — this made iteration and QA easy.

---

## 🧪 Testing

Testing includes:
- Model and controller tests
- ViewComponent rendering tests
- (Next step: system tests with Capybara)

I plan to integrate GitHub Actions for CI shortly.

---

## 📦 Export + Share

Survey responses can be downloaded as CSV. Sharing is enabled via the Web Share API and copy-to-clipboard functionality.

---

## 🔍 What I’d Do Next

- Add user accounts and login flows
- Real-time updates with Turbo Streams
- Public dashboards with shareable links
- Deploy to Fly.io or Render with CDN + edge caching
- Explore accessibility (a11y) audits and fixes

---

## 🎯 Final Thoughts

This project was about building something simple — but doing it **well**. It’s a Rails 7 playground, a UI/UX sandbox, and a component-driven toolkit rolled into one. If you're evaluating candidates for teams that care about code quality, performance, and user experience, I’d love to talk.

Check out the code: [github.com/advancedsoftwaresolutions/survey_app](https://github.com/advancedsoftwaresolutions/survey_app)
