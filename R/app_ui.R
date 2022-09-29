#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic

    tags$head(
      tags$script(src = "https://platform.twitter.com/widgets.js", charset = "utf-8"),
      tags$link(href = "https://fonts.googleapis.com/css?family=Fira+Mono", rel = "stylesheet"),
      tags$style(HTML('
      * {
        font-family: Fira Mono;
        font-size: 100%;
      }
      #sidebar {
         background-color: #fff;
         border: 0px;
      }
      .rt-th {
        display: none;
      }
      .rt-noData {
        display: none;
      }
      .rt-pagination-nav {
        float: left;
        width: 100%;
      }
    '))
    ),

    fluidPage(







        mod_query_corpus_ui("query_corpus_1"),
      )

  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "QuotableOffice"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
