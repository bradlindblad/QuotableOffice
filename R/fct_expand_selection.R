#' expand_selection
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
expand_selection <- function(idx=5, number_lines=4) {
  # idx = 5
  # number_lines = 4
  idx = as.numeric(idx)
  split <- number_lines/2

  # line_index <- lines |>
  #   dplyr::filter(index=idx
  #     stringi::stri_detect_regex(text, string)
  #   ) |> dplyr::pull(index)

  filter_seq_before <- (idx-split):idx
  filter_seq_after <- (idx+1):(idx+split)

  filter_seq <- c(filter_seq_before, filter_seq_after)

  lines |>
    dplyr::filter(index %in% filter_seq) |>
    dplyr::select(character,text,episode, season, episode_name)


}

