library(dplyr)

# weighting for how matches are scored (places more emphasison ideological
# targetting than geography or age)
subject_weight <- c(0, 0.5, 0.5, 1, 1, 3, 3)

# list of person attributes and dataframe of ads as input
# list is List(age, gender, political_orientaiton, region, interest)
# see server sample people for example
target <- function(l, df) {
  df %>%
    filter(
      (MinAge <= l[["age"]] | is.na(MinAge)) &
        (MaxAge >= l[["age"]] | is.na(MinAge)),
      Gender == l[["gender"]] | is.na(Gender),
      str_detect(Segment, l[["political_orientation"]]) | is.na(Segment),
      Region == l[["region"]] | is.na(Region),
      Interest == l[["interest"]] | is.na(Interest)
    ) %>%
    mutate(score = apply(., 1, function(x) {
      sum(
        ifelse(is.na(x), 0, 1) * subject_weight
      )
    })) %>%
    arrange(-score) %>%
    head(4) %>%
    pull(html)
}
