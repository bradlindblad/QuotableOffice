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
        5,
        h1("the quotable office"),
        tags$br(),
        p(HTML('<p>Ever wanted to use a quote from <a href="https://www.imdb.com/title/tt0386676/">the office</a> in a text
convo with your friends, but couldn\'t quite remember how it went?</p>
<p>Now, all you have to do is start typing how you think the line goes
and <strong>the quotable office</strong> will find the line you\'re
looking for.</p>
<p>To use it:</p>
<ul>
<li>Start typing the line below, the table below will find all
matches</li>
<li>Once you find the line, click it and the entire conversation will
come up</li>
</ul>
<p>Made with the <a href="https://bradlindblad.github.io/schrute/">schrute</a> R package by
<a href="https://technistema.com/">Brad Lindblad</a>
      <a href="https://github.com/bradlindblad/QuotableOffice"><img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" height="23" /></a>
</p>

')),
        tags$br(),
        shiny::textInput(ns("input_text"), width = "80%", label = "Start typing a quote from The Office", value = "bears beets"),
        tags$br(),
        tags$h4("Click a row below to see the conversation"),
        reactable::reactableOutput(ns("text_output"))
      ),
      column(1),
      column(5,
        align = "left",
        tags$br(),
        gt::gt_output(ns("final_gt")),
        tags$br(),
        fluidRow(column(12,
          align = "center",
          selectInput(ns("expand_selection"), multiple = FALSE, choices = c("Jim", "James", "Jimothy"), selected = "Jim", label = "Expand convo", selectize = T),
        ))
      ),
      column(1)
    ),
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
        need(input$input_text, message = "Text must be entered", label = ""),
        need(nrow(get_text(lines, input$input_text)) > 0, "No match for this phrase!", label = "")
      )
      reactable::reactable(
        columns = list(
          character = reactable::colDef(name = "Character", width = 80),
          index = reactable::colDef(name = "index", show = F)
        ),
        get_text(lines, input$input_text),
        onClick = "select",
        selection = "single",
        defaultPageSize = 10,
        defaultSelected = 1,
        highlight = T,
        outlined = T,
        compact = T
      )
    })


    # get reactable state
    selected <- reactive(
      reactable::getReactableState("text_output", "selected")
    )

    # 2. Index lines by derived index and return
    selected_line_index <- reactive(
      get_index(lines, input$input_text, selected())
    )

    # 3. Render gt
    output$final_gt <- gt::render_gt({
      validate(
        need(selected_line_index() > 0, message = "A line must be selected", label = "")
      )

      plot_gt(
        expand_selection(
          selected_line_index(),
          input$expand_selection
        )
      )
    })
  })
}

## To be copied in the UI
# mod_query_corpus_ui("query_corpus_1")

## To be copied in the server
# mod_query_corpus_server("query_corpus_1")
