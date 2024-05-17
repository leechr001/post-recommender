library(dplyr)

## requires entities df
get_summary_info <- function(df) {
  observations <- nrow(df)

  biggest_advertiser <- df %>%
    filter(advertiser != "") %>%
    group_by(advertiser) %>%
    summarise(total = n()) %>%
    filter(total == max(total)) %>%
    pull(advertiser)

  biggest_funder <- df %>%
    filter(paid_for_by != "") %>%
    group_by(paid_for_by) %>%
    summarise(total = n()) %>%
    filter(total == max(total)) %>%
    pull(paid_for_by)

  political_count <- df %>%
    filter(!is.na(political)) %>%
    nrow()
  non_political_count <- df %>%
    filter(!is.na(not_political)) %>%
    nrow()
  return(
    list(
      observations = observations,
      advertiser = biggest_advertiser,
      funder = biggest_funder,
      political_percentage = political_count /
        (political_count + non_political_count) * 100
    )
  )
}

## Removed code was problematic, I'll fix later -Michael
