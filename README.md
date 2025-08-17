# 📱 Flutter Quiz App with Leaderboard  
**Hiring Test Submission — RubizCode**  

A fully offline Flutter quiz application that supports **LaTeX rendering**, maintains a **local leaderboard** using Hive, and is built with **Riverpod** for state management.  

---

## 🚀 Features (MVP)  
- **Home Screen** — App title, *Start Quiz* button, and *Leaderboard* button  
- **Quiz Flow** —  
  - Loads questions from `assets/questions.json`  
  - Supports **LaTeX** in both questions and answers via `flutter_math_fork`  
  - Single-question view with 4 options, selectable once  
  - “Next” button to navigate  
  - Question progress indicator (e.g., Q3/10)  
- **Results Screen** —  
  - Displays score  
  - Prompts for player name  
  - Saves score to local leaderboard  
- **Leaderboard Screen** —  
  - Displays top scores sorted descending  
  - Persistent storage with **Hive**  

---

## ✨ Bonus Features Implemented  
- Timed questions (15 seconds per question)  
- Smooth animations between screens  
- Dark mode toggle  
- Category selection before quiz start  

---

## 📂 Tech Stack  
- **Flutter** — Stable channel  
- **Riverpod** — State management  
- **Hive** — Persistent leaderboard storage  
- **flutter_math_fork** — LaTeX/Math rendering  
- **flutter_animate** — Animations  

---

## 📦 Requirements  
- Flutter (Stable channel, latest)  
- Dart >= 3.0  
- Works entirely offline  

---

## 🛠 Setup & Run Instructions  

1️⃣ **Clone Repository**  
```bash
git clone <repo-link>
cd flutter_quiz_app
