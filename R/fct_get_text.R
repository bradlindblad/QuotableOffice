#' get_text
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
get_text <- function(lines, string) {

  # string <- "that's what she"

  string <- as.character(string)
  string <- tolower(string)
  lines$text <- tolower(lines$text)

  line_index <- lines |>
    dplyr::filter(
      stringi::stri_detect_regex(text, string)
    ) |>
    dplyr::select(index, character, text)
}

get_index <- function(lines, string, idx) {
  # idx = 5
  # string <- "that's what she"

  if (!is.null(string) & !is.null(idx)) {
    string <- as.character(string)
    string <- tolower(string)
    lines$text <- tolower(lines$text)

    line_index <- lines |>
      dplyr::filter(
        stringi::stri_detect_regex(text, string)
      ) |>
      dplyr::select(index, character, text) |>
      # line_index <- lines |>
      dplyr::slice(idx)
  }
}
