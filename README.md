# faecal_cortisol_metabolites_ungulate
# 🦌 Species-Specific Seasonal Variation in Faecal Cortisol Metabolites of Ungulates

[![R Studio](https://img.shields.io/badge/R-Studio-blue?logo=r&logoColor=white)](https://posit.co/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This repository contains the statistical modeling and data visualization pipelines developed to investigate seasonal fluctuations and physiological stress responses (faecal cortisol metabolite (FCM) ) across four ungulate species (*Bison bonasus*, *Sus scrofa*, *Capreolus capreolus*, and *Cervus elaphus*) in the Bieszczady Mountains, Poland.

---

## 🌲 Project Background & Objectives
Non-invasive physiological monitoring provides critical insights into how wildlife populations respond to environmental shifts, seasonal constraints, and anthropogenic pressures (such as tourism and management practices). This project evaluates:
* **Seasonal FCM variations** between high- and low-tourism periods across multiple ungulate taxa.
* **Species-specific physiological baselines** and response magnitudes (e.g., observed 2- to 3-fold increases during high-activity seasons in bison, wild boar, and roe deer).
* **Multifactorial relationships** involving visitor exposure, spatial distances from trails/roads, management designations, and individual sex.

---

## 🛠️ Tech Stack & Methodology
* **Statistical Environment:** R / RStudio (`tidyverse`, `lme4`, `lmerTest`, `emmeans`, `ggplot2`).
* **Modeling Approach:** Generalized Linear Mixed-Effects Models (GLMMs) / Linear Mixed-Effects Models (LMMs) to account for repeated measures and hierarchical variance.
* **Data Engineering:** tidyverse for data cleaning, aggregation, and handling physiological assay records.

---

## 📁 Repository Structure
```text
├── data/                 # Processed and anonymized FCM assay datasets (.csv)
├── r_scripts/            # Core R scripts for statistical modeling and physiological plots

│   └── 03_physiological_visualizations.R
├── outputs/              # High-resolution multi-panel plots and model summaries
└── README.md             # Project documentation
