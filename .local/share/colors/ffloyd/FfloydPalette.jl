module FfloydPalette

# Warm Cream color system. Matches ffloyd_colors.tex and the approved swatches.
# Categorical: swatch order. Sequential: low to high. Diverging: negative to zero to positive.
# include("FfloydPalette.jl"); using .FfloydPalette
# All colors are hex strings; loading this module requires no packages.
# Example with Plots.jl: plot(x, y; color=ff_green,
#     background_color=ff_background, foreground_color=ff_text)

export SYSTEM_NAME, COLORS, CATEGORICAL, SEQUENTIAL, DIVERGING, PALETTES
export ff_background, ff_text, ff_heading, ff_link, ff_ink
export ff_border, ff_separator, ff_bullet, ff_yellow, ff_green
export ff_blue, ff_terracotta, ff_violet, ff_rose, ff_olive
export ff_deep_blue, ff_cat_1, ff_cat_2, ff_cat_3, ff_cat_4
export ff_cat_5, ff_cat_6, ff_cat_7, ff_cat_8, ff_seq_1
export ff_seq_2, ff_seq_3, ff_seq_4, ff_seq_5, ff_seq_6
export ff_seq_7, ff_div_neg_4, ff_div_neg_3, ff_div_neg_2, ff_div_neg_1
export ff_div_zero, ff_div_pos_1, ff_div_pos_2, ff_div_pos_3, ff_div_pos_4

const SYSTEM_NAME = "Warm Cream"

const ff_background = "#EDE8D9"
const ff_text = "#25606F"
const ff_heading = "#164C67"
const ff_link = "#164C67"
const ff_ink = "#142C55"
const ff_border = "#9EB29B"
const ff_separator = "#739888"
const ff_bullet = "#56867E"
const ff_yellow = "#CB8A28"
const ff_green = "#008464"
const ff_blue = "#427EAF"
const ff_terracotta = "#C05B43"
const ff_violet = "#7864A0"
const ff_rose = "#B4567C"
const ff_olive = "#788238"
const ff_deep_blue = "#164C67"
const ff_cat_1 = "#CB8A28"
const ff_cat_2 = "#008464"
const ff_cat_3 = "#427EAF"
const ff_cat_4 = "#C05B43"
const ff_cat_5 = "#7864A0"
const ff_cat_6 = "#B4567C"
const ff_cat_7 = "#788238"
const ff_cat_8 = "#164C67"
const ff_seq_1 = "#EBD495"
const ff_seq_2 = "#C2C16F"
const ff_seq_3 = "#86B26E"
const ff_seq_4 = "#3E9F77"
const ff_seq_5 = "#1C847C"
const ff_seq_6 = "#0F6779"
const ff_seq_7 = "#164C67"
const ff_div_neg_4 = "#6E3223"
const ff_div_neg_3 = "#A94C2E"
const ff_div_neg_2 = "#CD7F51"
const ff_div_neg_1 = "#DDBC95"
const ff_div_zero = "#F4F0E4"
const ff_div_pos_1 = "#A6CBC7"
const ff_div_pos_2 = "#5EA2A8"
const ff_div_pos_3 = "#21778D"
const ff_div_pos_4 = "#164C67"

const COLORS = Dict(
    "ff_background" => ff_background,
    "ff_text" => ff_text,
    "ff_heading" => ff_heading,
    "ff_link" => ff_link,
    "ff_ink" => ff_ink,
    "ff_border" => ff_border,
    "ff_separator" => ff_separator,
    "ff_bullet" => ff_bullet,
    "ff_yellow" => ff_yellow,
    "ff_green" => ff_green,
    "ff_blue" => ff_blue,
    "ff_terracotta" => ff_terracotta,
    "ff_violet" => ff_violet,
    "ff_rose" => ff_rose,
    "ff_olive" => ff_olive,
    "ff_deep_blue" => ff_deep_blue,
    "ff_cat_1" => ff_cat_1,
    "ff_cat_2" => ff_cat_2,
    "ff_cat_3" => ff_cat_3,
    "ff_cat_4" => ff_cat_4,
    "ff_cat_5" => ff_cat_5,
    "ff_cat_6" => ff_cat_6,
    "ff_cat_7" => ff_cat_7,
    "ff_cat_8" => ff_cat_8,
    "ff_seq_1" => ff_seq_1,
    "ff_seq_2" => ff_seq_2,
    "ff_seq_3" => ff_seq_3,
    "ff_seq_4" => ff_seq_4,
    "ff_seq_5" => ff_seq_5,
    "ff_seq_6" => ff_seq_6,
    "ff_seq_7" => ff_seq_7,
    "ff_div_neg_4" => ff_div_neg_4,
    "ff_div_neg_3" => ff_div_neg_3,
    "ff_div_neg_2" => ff_div_neg_2,
    "ff_div_neg_1" => ff_div_neg_1,
    "ff_div_zero" => ff_div_zero,
    "ff_div_pos_1" => ff_div_pos_1,
    "ff_div_pos_2" => ff_div_pos_2,
    "ff_div_pos_3" => ff_div_pos_3,
    "ff_div_pos_4" => ff_div_pos_4,
)

const CATEGORICAL = [ff_cat_1, ff_cat_2, ff_cat_3, ff_cat_4, ff_cat_5, ff_cat_6, ff_cat_7, ff_cat_8]
const SEQUENTIAL = [ff_seq_1, ff_seq_2, ff_seq_3, ff_seq_4, ff_seq_5, ff_seq_6, ff_seq_7]
const DIVERGING = [ff_div_neg_4, ff_div_neg_3, ff_div_neg_2, ff_div_neg_1, ff_div_zero, ff_div_pos_1, ff_div_pos_2, ff_div_pos_3, ff_div_pos_4]

const PALETTES = Dict(
    "categorical" => CATEGORICAL,
    "sequential" => SEQUENTIAL,
    "diverging" => DIVERGING,
)

end # module FfloydPalette
