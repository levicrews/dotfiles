# Metromuted colour system. Backgrounds are included for slides and figures.
metromuted_background <- "#FAFAFA"
metromuted_white <- "#FFFFFF"
metromuted_off_white <- "#F8F8F5"
metromuted_light_gray <- "#E4E7E8"
metromuted_mid_gray <- "#737B7E"
metromuted_dark_gray <- "#263238"
metromuted_categorical <- c("#B71E2E", "#E68B28", "#E9A508", "#4B8EC2", "#14364C", "#227763")
metromuted_sequential <- c("#E9A508", "#56A841", "#15866F", "#2C6671", "#3F4274", "#5B176C")
metromuted_diverging <- c("#C7352C", "#EA8F2F", "#FCD35E", "#A4D6E9", "#278EE8", "#2A36A0")
metromuted_palettes <- list(categorical = metromuted_categorical, sequential = metromuted_sequential, diverging = metromuted_diverging)

scale_color_metromuted <- function(..., values = metromuted_categorical) ggplot2::scale_color_manual(..., values = values)
scale_fill_metromuted <- function(..., values = metromuted_categorical) ggplot2::scale_fill_manual(..., values = values)
