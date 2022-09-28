#' plot_gt
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_gt <- function(df) {

    headshots <- c(
      "Andy", "Creed", "Erin", "Kevin", "Oscar",
      "Roy", "Toby", "Angela", "Darryl", "Jim",
      "Meredith", "Pam", "Ryan", "Dwight" ,"Kelly",
      "Michael", "Phyllis", "Stanley"
    )

    df <- df |>
      dplyr::mutate(Character = dplyr::case_when(
        character %in% headshots ~ paste0("images/",character,".png"),
        !character %in% headshots ~ "images/Anon.png"
      )) |>
      dplyr::mutate(` ` = character) |>
      dplyr::select(Character, ` `, Line = text)




    gt::gt(df) |>
    gt::text_transform(
      locations = gt::cells_body(columns = Character),
      fn = function(x) {
        gt::local_image(

          filename = x,

          height = as.numeric(92)
        )
      }
    )
}
