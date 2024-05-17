library(dplyr)
library(ggplot2)
library(stringr)
library(plotly)

audience_of_campaign <- function(df) {
  ad_type <- df %>%
    filter(type == "politics") %>%
    filter(str_sub(name, 1, 11) == "US Politics") %>%
    mutate(type_of_pol = str_sub(name, 14, -2)) %>%
    group_by(type_of_pol)

  scatter_plot <- ggplot(
    data = ad_type,
    aes(type_of_pol, audience_size / 1000000)
  ) +
    geom_bar(stat = "identity", color = "blue", fill = "white") +
    ggtitle("Number of Audience for Each Political Spectrum")
  scatter_plot <- scatter_plot + labs(
    x = "Political Spectrum",
    y = "Size of Audience (1,000,000)"
  )
  scatter_plot <- ggplotly(scatter_plot)
  return(scatter_plot)
}
