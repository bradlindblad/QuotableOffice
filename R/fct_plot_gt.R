#' plot_gt
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
plot_gt <- function(df) {
    # df <- df[1:3,]
    headshots <- c(
      "Andy", "Creed", "Erin", "Kevin", "Oscar",
      "Roy", "Toby", "Angela", "Darryl", "Jim",
      "Meredith", "Pam", "Ryan", "Dwight" ,"Kelly",
      "Michael", "Phyllis", "Stanley"
    )

    title <- df |>
      dplyr::pull(episode_name) |> unique()
    title_meta <- df |>
      dplyr::mutate(meta =
        paste0("Season ", season, " Ep.", episode)
      ) |> dplyr::pull(meta) |> unique()
    highlight_row <- ceiling(nrow(df)/2)


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
    ) |>

      gt::tab_header(
        title = title,
        subtitle = title_meta
      ) |>

      gt::tab_source_note(
        gt::md("Source: [schrute R package](https://bradlindblad.github.io/schrute/) by [Brad Lindblad](https://technistema.com/)")
      ) |>

      gt::tab_style(
        gt::cell_text(color = "blue"),
        locations = gt::cells_body(
          columns = everything(),
          rows = highlight_row

        )
      ) |>
      gt::cols_width(
        Line ~ px(600)
      )

    # gt::gtsave(v, "/home/brad/Desktop/gt.png")

}
