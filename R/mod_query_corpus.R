#' query_corpus UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_query_corpus_ui <- function(id){
  ns <- NS(id)
  tagList(
    shiny::textInput(ns("input_text"), label = "Start typing a quote from The Office"),
    shiny::sliderInput(ns("expand_selection"), label = "Expand conversation", min = 2, max = 8, step = 2, value = 2),
    shiny::actionButton(ns("submit_it") , label = "submit"),
    DT::DTOutput(ns("text_output")),
    textOutput(ns("foo"))
  )
}

#' query_corpus Server Functions
#'
#' @noRd
mod_query_corpus_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns


    output$text_output <- DT::renderDT({get_text(lines, input$input_text, input$expand_selection)}, server = T, selection ="single")


    # this gets the row of the DT, not lines like we need
    output$foo <- renderPrint({
      s <- input$text_output_rows_selected
      if (length(s)) {
        cat('These rows were selected:\n\n')
        cat(s, sep = ', ')
      }

    })

  })
}

## To be copied in the UI
# mod_query_corpus_ui("query_corpus_1")

## To be copied in the server
# mod_query_corpus_server("query_corpus_1")
