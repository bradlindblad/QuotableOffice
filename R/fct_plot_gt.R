#' plot_gt
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_gt <- function(df) {

    gt::gt(df) |>
    gt::text_transform(
      locations = gt::cells_body(columns = character),
      fn = function(x) {
        gt::local_image(
          filename = paste0("images/",x,".png"),
          height = as.numeric(92)
        )
      }
    )
}
