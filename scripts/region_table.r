library(dplyr)

## requires targets df
region_table <- function(df) {
  by_target_region <- df %>%
    filter(!is.na(Region)) %>%
    group_by(Region) %>%
    summarise(total = n()) %>%
    arrange(-total)

  return(by_target_region)
}
