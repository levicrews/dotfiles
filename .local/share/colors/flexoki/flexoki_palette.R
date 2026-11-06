# Flexoki colour system; official base and accent values.
flexoki_background <- "#FFFCF0"
flexoki_ink <- "#282726"
flexoki_categorical <- c("#AF3029", "#BC5215", "#AD8301", "#66800B", "#24837B", "#205EA6", "#5E409D", "#A02F6F")
flexoki_sequential <- c("#F6E2A0", "#B6BA62", "#7F993D", "#408B65", "#22758B", "#1E5697", "#163B66")
flexoki_diverging <- c("#942822", "#C03E35", "#DA702C", "#F9AE77", "#E6E4D9", "#92BFDB", "#4385BE", "#3171B2", "#163B66")
flexoki_palettes <- list(categorical = flexoki_categorical, sequential = flexoki_sequential, diverging = flexoki_diverging)

scale_color_flexoki <- function(..., values = flexoki_categorical) ggplot2::scale_color_manual(..., values = values)
scale_fill_flexoki <- function(..., values = flexoki_categorical) ggplot2::scale_fill_manual(..., values = values)
