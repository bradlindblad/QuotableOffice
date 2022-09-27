#' query_corpus UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_query_corpus_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shiny::textInput(ns("input_text"), label = "Start typing a quote from The Office", value = "That's what she said"),
    DT::DTOutput(ns("text_output")),
    # textOutput(ns("print_interim_line_index")),
    # DT::DTOutput(ns("bra_print")),
    shiny::sliderInput(ns("expand_selection"), label = "Expand conversation", min = 2, max = 8, step = 2, value = 2),
    gt::gt_output(ns("final_gt"))

  )
}

#' query_corpus Server Functions
#'
#' @noRd
mod_query_corpus_server <- function(id, r) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # 1. Print DT so can select index
    output$text_output <- DT::renderDT(
      {
        get_text(lines, input$input_text)
      },
      server = T,
      selection = "single"
    )

    # 1.1 Print selected index from above
    interim_row_index <- reactive(
      input$text_output_rows_selected
    )

    # FOR PRINTING ONLY ----
    output$print_interim_line_index <- renderPrint({
      s <- input$text_output_rows_selected
      if (length(s)) {
        cat("These rows were selected:\n\n")
        cat(s, sep = ", ")
      }
    })

    # 2. Index lines by derived index and return
    selected_line_index <-  reactive(
      get_index(lines, input$input_text, input$text_output_rows_selected)
    )

    # FOR PRINTING ONLY ----
    output$bra_print <-
      DT::renderDT({get_index(lines, input$input_text, input$text_output_rows_selected)})

    # 3. Render gt


        output$final_gt <- gt::render_gt({plot_gt(expand_selection(selected_line_index(), input$expand_selection))})










    # copy for printing
    # output$interim_line_index <-
    #   get_text(lines, input$input_text)


    # this returns actual index
    # eventReactive(input$text_input, {
    #   output$print_interim_line_index <-renderText(get_index(lines, input$text_input, interim_row_index()))
    #
    # })

  })
}

## To be copied in the UI
# mod_query_corpus_ui("query_corpus_1")

## To be copied in the server
# mod_query_corpus_server("query_corpus_1")
