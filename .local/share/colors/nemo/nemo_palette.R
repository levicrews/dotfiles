# Nemo colour system. Categorical order is chart-ready; sequential is low to high.
nemo_background <- "#FBFAF7"
nemo <- list(
  categorical = c("#6182B5", "#AF3127", "#90A954", "#D99C37", "#112A3C", "#3E7C73", "#756889", "#C5B868"),
  sequential = c("#FAC764", "#9EAD56", "#619165", "#3E757A", "#335677", "#1F3E56", "#112A3C"),
  diverging = c("#8D211D", "#AF3127", "#C86D3C", "#DAC0A6", "#F4F1EA", "#C4C2D1", "#91A4BE", "#6182B5", "#112A3C")
)

scale_nemo <- function(type = "categorical", discrete = TRUE, ...) {
  stopifnot(type %in% names(nemo))
  cols <- nemo[[type]]
  if (discrete) ggplot2::scale_colour_manual(values = cols, ...)
  else ggplot2::scale_colour_gradientn(colours = cols, ...)
}
