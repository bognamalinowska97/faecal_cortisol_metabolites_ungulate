# =====================================================================
# Title: Physiological Stress Response in Ungulates (Faecal Cortisol Metabolites)
# Description: GLMMs, Gamma GLMs, Estimated Marginal Means, and Publication-Ready
#              Visualizations for Ungulate Species in Mountainous Areas
# =====================================================================

# Load required libraries
library(lme4)
library(lmerTest)
library(emmeans)
library(ggplot2)
library(dplyr)

# =====================================================================
# 1. Exploratory Models & Preliminary Analysis
# =====================================================================

# Initial GLMM with Gaussian family for European bison
model_glmm <- glmer(
  oxo ~ -1 + Tourist + Protection + Distance + `People/day` + (1 | Spot),
  data = data,
  family = gaussian(link = "identity")
)
summary(model_glmm)

# Linear Mixed Model version (to check p-values directly via lmerTest)
model_lmer <- lmer(
  oxo ~ -1 + Tourist + Protection + Distance + `People/day` + (1 | Spot),
  data = data
)
summary(model_lmer)

# Alternative specifications and interactions
model_lmer_int1 <- lmer(oxo ~ Tourist + `People/day` + Distance + (1 | Protection), data = data)
summary(model_lmer_int1)

model_lmer_int2 <- lmer(oxo ~ Tourist * `People/day` + Tourist * Distance + (1 | Protection), data = data)
summary(model_lmer_int2)


# =====================================================================
# 2. Species-Specific GLM Analyses (Gamma Family with Log-Link)
# =====================================================================

# --- A. Roe deer (Capreolus capreolus) ---
modelsarna_glm <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + Distance + Protection + Sex,
  family = Gamma(link = "log"),
  data = sarna
)
summary(modelsarna_glm)

emm_season_sarna <- emmeans(modelsarna_glm, ~ `Tourist season`)
summary(emm_season_sarna, type = "response")
contrast(emm_season_sarna, method = "pairwise")

sex_sarna <- emmeans(modelsarna_glm, ~ Sex)
contrast(sex_sarna, method = "pairwise")

distance_sarna <- emmeans(modelsarna_glm, ~ Distance)
contrast(distance_sarna, method = "pairwise")

protection_sarna <- emmeans(modelsarna_glm, ~ Protection)
contrast(protection_sarna, method = "pairwise")


# --- B. Red deer (Cervus elaphus) ---
modeljelen_glm <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + Distance + Protection + Sex,
  family = Gamma(link = "log"),
  data = jelen
)
summary(modeljelen_glm)

emm_season_jelen <- emmeans(modeljelen_glm, ~ `Tourist season`)
summary(emm_season_jelen, type = "response")
contrast(emm_season_jelen, method = "pairwise")

sex_jelen <- emmeans(modeljelen_glm, ~ Sex)
contrast(sex_jelen, method = "pairwise")

distance_jelen <- emmeans(modeljelen_glm, ~ Distance)
contrast(distance_jelen, method = "pairwise")

protection_jelen <- emmeans(modeljelen_glm, ~ Protection)
contrast(protection_jelen, method = "pairwise")


# --- C. European wild boar (Sus scrofa) ---
modeldzik_glm <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + `Distance [m]` + Protection + Sex,
  family = Gamma(link = "log"),
  data = dzik
)
summary(modeldzik_glm)

sex_dzik <- emmeans(modeldzik_glm, ~ Sex)
contrast(sex_dzik, method = "pairwise")

distance_dzik <- emmeans(modeldzik_glm, ~ `Distance [m]`)
contrast(distance_dzik, method = "pairwise")

protection_dzik <- emmeans(modeldzik_glm, ~ Protection)
contrast(protection_dzik, method = "pairwise")


# --- D. European bison (Bison bonasus) ---
modelzubr_glm <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + Distance + Protection + Sex,
  family = Gamma(link = "log"),
  data = zubr
)
summary(modelzubr_glm)

sex_zubr <- emmeans(modelzubr_glm, ~ Sex)
contrast(sex_zubr, method = "pairwise")

distance_zubr <- emmeans(modelzubr_glm, ~ Distance)
contrast(distance_zubr, method = "pairwise")

protection_zubr <- emmeans(modelzubr_glm, ~ Protection)
contrast(protection_zubr, method = "pairwise")

people_zubr <- emmeans(modelzubr_glm, ~ `People/day`)
contrast(people_zubr, method = "pairwise")


# =====================================================================
# 3. Post-Review Refined Models & Publication Plots
# =====================================================================

# --- Post-Review Model: Roe deer ---
model_sarna_rev <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + Distance + Protection + Sex,
  family = Gamma(link = "log"),
  data = sarna
)
summary(model_sarna_rev)

emm_sarna <- as.data.frame(
  emmeans(model_sarna_rev, ~ `Tourist season`, type = "response")
)

# Plot: Roe deer FCM levels with model estimates and confidence intervals
ggplot(sarna, aes(x = `Tourist season`, y = `11-oxo [ng/g]`)) +
  geom_jitter(width = 0.15, alpha = 0.5, aes(colour = `People/day`)) +
  geom_point(
    data = emm_sarna,
    aes(x = `Tourist season`, y = response),
    size = 4, colour = "black", fill = "white", shape = 21, inherit.aes = FALSE
  ) +
  geom_errorbar(
    data = emm_sarna,
    aes(x = `Tourist season`, ymin = lower.CL, ymax = upper.CL),
    width = 0.15, linewidth = 0.8, colour = "black", inherit.aes = FALSE
  ) +
  facet_grid(
    Sex ~ Protection,
    labeller = labeller(
      Protection = c("LP" = "State forest", "PN" = "National Park"),
      Sex = c("F" = "Female", "M" = "Male")
    )
  ) +
  scale_x_discrete(labels = c(NO = "Outside season", YES = "Tourist season")) +
  labs(
    title = "Roe deer",
    x = "",
    y = expression("11-oxo-etiocholanolone (ng g"^{-1}*")"),
    colour = "Visitors/day"
  ) +
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5))


# --- Post-Review Model: Wild boar ---
model_dzik_rev <- glm(
  `11-oxo [ng/g]` ~ `Tourist season` + `People/day` + `Distance [m]` + Protection + Sex,
  family = Gamma(link = "log"),
  data = dzik
)
summary(model_dzik_rev)

emm_dzik <- as.data.frame(
  emmeans(model_dzik_rev, ~ `Tourist season`, type = "response")
)

n_samples_dzik <- table(dzik$Protection)
protection_labels_dzik <- c(
  "LP" = paste0("State forest\nN = ", n_samples_dzik["LP"]),
  "PN" = paste0("National Park\nN = ", n_samples_dzik["PN"])
)

# Plot: Wild boar FCM levels with sample sizes and model estimates
ggplot(dzik, aes(x = `Tourist season`, y = `11-oxo [ng/g]`)) +
  geom_jitter(width = 0.15, alpha = 0.5, aes(colour = `People/day`)) +
  geom_point(
    data = emm_dzik,
    aes(x = `Tourist season`, y = response),
    size = 4, colour = "black", fill = "white", shape = 21, inherit.aes = FALSE
  ) +
  geom_errorbar(
    data = emm_dzik,
    aes(x = `Tourist season`, ymin = lower.CL, ymax = upper.CL),
    width = 0.15, linewidth = 0.8, colour = "black", inherit.aes = FALSE
  ) +
  facet_grid(
    Sex ~ Protection,
    labeller = labeller(
      Protection = protection_labels_dzik,
      Sex = c("F" = "Female", "M" = "Male")
    )
  ) +
  scale_x_discrete(labels = c(NO = "Low-tourism", YES = "High-tourism")) +
  labs(
    title = "Wild boar",
    x = "Season",
    y = expression("11-oxo-etiocholanolone (ng g"^{-1}*")"),
    colour = "Visitors/day"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5),
    strip.text.x = element_text(face = "bold"),
    strip.text.y = element_text(face = "bold")
  )