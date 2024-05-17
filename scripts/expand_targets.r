library(dplyr)
library(tidyr)
library(jsonlite)

# converts json in targets column to columns at end of data fram
expand_targets <- function(df) {
  l <- lapply(df[, "targets"], function(x) {
    tryCatch(
      {
        fromJSON(x)
      },
      error = function(e) NA
    )
  })
  l <- lapply(l, function(x) {
    tryCatch(
      {
        spread(x, key = target, value = segment)
      },
      error = function(e) data.frame()
    )
  })
  names(l) <- df$id
  df_to_join <- bind_rows(l, .id = "id")
  df <- full_join(df, df_to_join)
  return(df)
}
