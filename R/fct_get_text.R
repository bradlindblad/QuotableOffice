#' get_text
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
get_text <- function(lines, string, number_lines) {
  number_lines = 8
  string <- "walk away"

  string <- as.character(string)
  string <- tolower(string)
  lines$text <- tolower(lines$text)

  split <- number_lines/2


  line_index <- lines |>
    dplyr::filter(
      stringi::stri_detect_regex(text, string)
    ) |> dplyr::pull(index)

  filter_seq_before <- (line_index-split):line_index
  filter_seq_after <- (line_index+1):(line_index+split)

  filter_seq <- c(filter_seq_before, filter_seq_after)

  lines |>
    dplyr::filter(index %in% filter_seq) |>
    dplyr::select(character,text) |> View()
}
