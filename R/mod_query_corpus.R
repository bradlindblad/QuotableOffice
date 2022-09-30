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

    fluidRow(

      column(
        4,




        h1("the quotable office"),
        # column(
        #   width = 12, align = "left",
          tags$br(),
          p(HTML('<p>Ever wanted to use a quote from <a href="https://www.imdb.com/title/tt0386676/">the office</a> in a text
convo with your friends, but couldn’t quite remember how it went? You’ve
come to the right place.</p>
<p>Now, all you have to do is start typing how you think the line goes
and <strong>the quotable office</strong> will find the line you’re
looking for.</p>
<p>To use it:</p>
<ul>
<li>Start typing the line below, the table below will find all
matches</li>
<li>Once you find the line, click it and the entire conversation will
come up</li>
</ul>
<p>Made with the <a href="https://bradlindblad.github.io/schrute/">schrute</a> R package by
<a href="https://technistema.com/">Brad Lindblad</a></p>

')),
tags$br(),






        shiny::textInput(ns("input_text"), width = "80%", label = "Start typing a quote from The Office", value = "That's what she said"),
        tags$br(),
        reactable::reactableOutput(ns("text_output"))
      ),
      column(1),

      column(6,align = "left",
             tags$br(),
             shiny::sliderInput(ns("expand_selection"), label = "Expand conversation", min = 2, max = 8, step = 2, value = 2),
             gt::gt_output(ns("final_gt"))
      ),
      column(1)

    )
    ,
    # textOutput(ns("print_interim_line_index")),
    # DT::DTOutput(ns("bra_print")),


  )
}

#' query_corpus Server Functions
#'
#' @noRd
mod_query_corpus_server <- function(id, r) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    # 1. Print reactable so can select index
    output$text_output <- reactable::renderReactable({

      validate(
        need(input$input_text, message = "Text must be entered", label = "")
      )
        reactable::reactable(get_text(lines, input$input_text),onClick = "select",
                             selection = "single", defaultPageSize = 5, defaultSelected = 1)


    })

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

    # get reactable state
    selected <- reactive(
      reactable::getReactableState("text_output", "selected")
    )

    # 2. Index lines by derived index and return
    selected_line_index <-  reactive(
      get_index(lines, input$input_text, selected())
    )

    # FOR PRINTING ONLY ----
    # output$bra_print <- DT::renderDT({
    #
    #   get_index(lines, input$input_text,  selected())
    #   })

    # 3. Render gt


        output$final_gt <- gt::render_gt({
          validate(
            need(selected_line_index() > 0, message = "A line must be selected", label = "")
          )

          plot_gt(
            expand_selection(
              selected_line_index()
              , input$expand_selection)
            )}
          )










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
