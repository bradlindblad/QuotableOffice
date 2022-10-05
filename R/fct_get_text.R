#' clean_string
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
clean_string <- function(string) {
  string |>
    as.character() |>
    tolower() |>
    stringi::stri_replace_all(regex = "[[:punct:]]", "") |>
    trimws()
}

#' get_text
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#'
get_text <- function(lines, string) {

  # string <- "bears beets."

  # clean input string
  string <- string |>
    clean_string()

  # clean string in df
  lines$text2 <- clean_string(lines$text)

  line_index <- lines |>
    dplyr::filter(
      stringi::stri_detect_regex(text2, string)
    ) |>
    dplyr::select(index, character, text)
}

get_index <- function(lines, string, idx) {
  # idx = 5
  # string <- "that's what she"

  if (!is.null(string) & !is.null(idx)) {
    string <- string |>
      clean_string()

    lines$text2 <- clean_string(lines$text)

    line_index <- lines |>
      dplyr::filter(
        stringi::stri_detect_regex(text2, string)
      ) |>
      dplyr::select(index, character, text) |>
      # line_index <- lines |>
      dplyr::slice(idx)
  }
}
