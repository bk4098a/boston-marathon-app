# 🏁 Boston Marathon 2023 – Interactive Shiny App

This web application provides an interactive dashboard to explore runner performance trends from the 2023 Boston Marathon, with a focus on bib number assignments and their correlation with finish times.

Built with **R and Shiny**, the app allows users to filter runners by age group, gender, and net finish time, and visualize trends through dynamic plots and tables.

---

## 📊 Data Source

The dataset was retrieved from the [Score Network](https://data.scorenetwork.org/running/boston_marathon_2023.html), which provides public race data from major marathons.

- 📅 Year: 2023
- 🏃‍♂️ Total Runners: ~26,000
- 🎯 Key Variables Used:
  - `bib_number` – Assigned based on qualifying time
  - `finish_net_minutes` – Net chip time in minutes
  - `gender`, `age_group` – Demographics for segmentation

---

## 📌 Key Questions

- 📉 Does a lower bib number lead to a faster finish time?
- 🚻 How do gender and age affect marathon performance?
- 📊 What trends can help sports analysts and organizers make better decisions?

---

## 🧪 Features

- Interactive filtering by:
  - Gender (`M`, `W`, or All)
  - Age group
  - Finish time range
- Summary table (mean time & count by demographic)
- Plotly-based bar and scatter plots
- CSV download of filtered dataset
- Fully styled with `bslib` and `plotly`

---

## 📂 File Structure

| File | Description |
|------|-------------|
| `app.R` | Main Shiny application file |
| `boston_marathon_2023.csv` | Cleaned dataset |
| `README.md` | This file |
| `img/preview.png` | Screenshot of the app UI (optional) |

---

## 🚀 Live Demo

▶️ [Launch the App](https://bk4098a.shinyapps.io/boston_marathon_2023_app/)

---

## 💻 Tech Stack

- **Language**: R
- **Frontend**: `shiny`, `bslib`, `plotly`, `DT`, `shinyWidgets`
- **Backend/Data**: `dplyr`, `readr`, `ggplot2`
- **Deployment**: [Shinyapps.io](https://www.shinyapps.io/)

---

## 📊 Related Project

Looking for the original presentation and statistical analysis?

👉 [View the presentation repository](https://github.com/bk4098a/boston-marathon-presentation)  
👉 [Slides (HTML)](https://bk4098a.github.io/boston-marathon-presentation/)

---

## 👤 Author

Byeolha Kim  
🎓 MA in International Economics  
📍 American University | 🇺🇸 Washington D.C. / 🇰🇷 Seoul  
🔗 [LinkedIn](https://www.linkedin.com/in/byeolha-kim-305525288)

---

## 🏷️ Tags

`R` `Shiny` `Sports Analytics` `Boston Marathon` `Data Science Portfolio` `Shiny Dashboard`
