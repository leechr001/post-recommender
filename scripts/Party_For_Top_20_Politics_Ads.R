library(dplyr)
library(ggplot2)

# This shows the party of the top 20 politics ads on facebook collected.
# Interestingly, the only top 20 republicans ad was Donald Trump
# (10th with 89 ads). On the other hand, there are 8 out of the top
# 20 were democrats ad. Non-profit contribute to the highest proportion
# of ads on facebook.

party_top_20_politics_ad <- function(df) {
  top20 <- df %>%
    group_by(title) %>%
    summarize(count = n()) %>%
    arrange(-count) %>%
    slice(1:20)
  democrats <- 145 + 128 + 118 + 97 + 94 + 73 + 71 + 61
  republicans <- 89
  non_profit <- 255 + 126 + 121 + 91 + 84 + 77 + 70 + 68 + 62
  Other <- 78 + 65
  Totalads <- democrats + republicans + non_profit + Other
  Party <-
    data.frame(
      Parties = c(
        "Democrats",
        "Republicans (Donald Trump)",
        "Non Profit", "Other"
      ),
      Count = c(
        democrats,
        republicans,
        non_profit,
        Other
      )
    )
  ggplot(Party, aes(x = "", y = Count, fill = factor(Parties))) +
    geom_bar(width = 1, stat = "identity") +
    geom_text(aes(label = paste(round(Count / Totalads * 100, 1), "%")),
      position = position_stack(vjust = 0.5)
    ) +
    theme_classic() +
    theme(
      plot.title = element_text(hjust = 0.5),
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank()
    ) +
    labs(
      fill = "Category",
      x = NULL,
      y = NULL,
      title = "Parties of Top 20 Advertisement"
    ) +
    coord_polar("y")
}
