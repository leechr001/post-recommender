library(dplyr)

## requires targets df
age_table <- function(df) {
  by_target_age <- df %>%
    filter(!is.na(Age)) %>%
    group_by(Age) %>%
    summarise(total = n())

  return(by_target_age)
}
