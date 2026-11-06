# Warm Cream color system. Matches ffloyd_colors.tex and the approved swatches.
# Categorical: swatch order. Sequential: low to high. Diverging: negative to zero to positive.
# source("ffloyd_palette.R")
# Example: plot(x, y, col = ff_green)
# Example: par(bg = ff_background, fg = ff_text, col.axis = ff_text,
#              col.lab = ff_text, col.main = ff_heading)
# ggplot2 helpers below are optional; no packages are required to load the colors.

ff_background <- "#EDE8D9"
ff_text <- "#25606F"
ff_heading <- "#164C67"
ff_link <- "#164C67"
ff_ink <- "#142C55"
ff_border <- "#9EB29B"
ff_separator <- "#739888"
ff_bullet <- "#56867E"
ff_yellow <- "#CB8A28"
ff_green <- "#008464"
ff_blue <- "#427EAF"
ff_terracotta <- "#C05B43"
ff_violet <- "#7864A0"
ff_rose <- "#B4567C"
ff_olive <- "#788238"
ff_deep_blue <- "#164C67"
ff_cat_1 <- "#CB8A28"
ff_cat_2 <- "#008464"
ff_cat_3 <- "#427EAF"
ff_cat_4 <- "#C05B43"
ff_cat_5 <- "#7864A0"
ff_cat_6 <- "#B4567C"
ff_cat_7 <- "#788238"
ff_cat_8 <- "#164C67"
ff_seq_1 <- "#EBD495"
ff_seq_2 <- "#C2C16F"
ff_seq_3 <- "#86B26E"
ff_seq_4 <- "#3E9F77"
ff_seq_5 <- "#1C847C"
ff_seq_6 <- "#0F6779"
ff_seq_7 <- "#164C67"
ff_div_neg_4 <- "#6E3223"
ff_div_neg_3 <- "#A94C2E"
ff_div_neg_2 <- "#CD7F51"
ff_div_neg_1 <- "#DDBC95"
ff_div_zero <- "#F4F0E4"
ff_div_pos_1 <- "#A6CBC7"
ff_div_pos_2 <- "#5EA2A8"
ff_div_pos_3 <- "#21778D"
ff_div_pos_4 <- "#164C67"

ff_colors <- c(
  ff_background = ff_background,
  ff_text = ff_text,
  ff_heading = ff_heading,
  ff_link = ff_link,
  ff_ink = ff_ink,
  ff_border = ff_border,
  ff_separator = ff_separator,
  ff_bullet = ff_bullet,
  ff_yellow = ff_yellow,
  ff_green = ff_green,
  ff_blue = ff_blue,
  ff_terracotta = ff_terracotta,
  ff_violet = ff_violet,
  ff_rose = ff_rose,
  ff_olive = ff_olive,
  ff_deep_blue = ff_deep_blue,
  ff_cat_1 = ff_cat_1,
  ff_cat_2 = ff_cat_2,
  ff_cat_3 = ff_cat_3,
  ff_cat_4 = ff_cat_4,
  ff_cat_5 = ff_cat_5,
  ff_cat_6 = ff_cat_6,
  ff_cat_7 = ff_cat_7,
  ff_cat_8 = ff_cat_8,
  ff_seq_1 = ff_seq_1,
  ff_seq_2 = ff_seq_2,
  ff_seq_3 = ff_seq_3,
  ff_seq_4 = ff_seq_4,
  ff_seq_5 = ff_seq_5,
  ff_seq_6 = ff_seq_6,
  ff_seq_7 = ff_seq_7,
  ff_div_neg_4 = ff_div_neg_4,
  ff_div_neg_3 = ff_div_neg_3,
  ff_div_neg_2 = ff_div_neg_2,
  ff_div_neg_1 = ff_div_neg_1,
  ff_div_zero = ff_div_zero,
  ff_div_pos_1 = ff_div_pos_1,
  ff_div_pos_2 = ff_div_pos_2,
  ff_div_pos_3 = ff_div_pos_3,
  ff_div_pos_4 = ff_div_pos_4
)

ff_categorical <- c(ff_cat_1, ff_cat_2, ff_cat_3, ff_cat_4, ff_cat_5, ff_cat_6, ff_cat_7, ff_cat_8)
ff_sequential <- c(ff_seq_1, ff_seq_2, ff_seq_3, ff_seq_4, ff_seq_5, ff_seq_6, ff_seq_7)
ff_diverging <- c(ff_div_neg_4, ff_div_neg_3, ff_div_neg_2, ff_div_neg_1, ff_div_zero, ff_div_pos_1, ff_div_pos_2, ff_div_pos_3, ff_div_pos_4)

ff_palettes <- list(
  categorical = ff_categorical,
  sequential = ff_sequential,
  diverging = ff_diverging
)

scale_color_ff <- function(..., values = ff_categorical) {
  ggplot2::scale_color_manual(..., values = values)
}

scale_fill_ff <- function(..., values = ff_categorical) {
  ggplot2::scale_fill_manual(..., values = values)
}
