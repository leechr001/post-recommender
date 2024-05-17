library(dplyr)
library(treemap)
library(lintr)

# This shows the top 10 political ads on facebook.
# This has a strong correlation to have much actualy money was spent
# on advertising. (More money spent = higher chance of getting collected)
# Donald Trump was only the 10th in the number of ads collected.
# On the other hand, Beto O'Rourke (democratic) is the first among politicians.

top_10_politics_ad <- function(df) {
  top10 <- df %>%
    group_by(title) %>%
    summarize(count = n()) %>%
    arrange(-count) %>%
    slice(1:10)
  graph <- treemap(
    top10,
    index = "title",
    vSize = "count",
    type = "index",
    title = "Top 10 Political Ads"
  )
}
