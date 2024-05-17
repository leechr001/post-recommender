library(dplyr)
library(tidyr)
library(jsonlite)

expand_entities <- function(df) { # ex. expand(sample_of_df)
  l <- lapply(df[, "entities"], function(x) {
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
        spread(x, key = entity_type, value = entity)
      },
      error = function(e) data.frame()
    )
  })
  names(l) <- df$id
  df_to_join <- bind_rows(l, .id = "id")
  df <- full_join(df, df_to_join)
  return(df)
}
