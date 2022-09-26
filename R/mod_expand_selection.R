#' expand_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_expand_selection_ui <- function(id){
  ns <- NS(id)
  tagList(

    shiny::textInput(ns("input_text"), label = "Start typing a quote from The Office")

  )
}

#' expand_selection Server Functions
#'
#' @noRd
mod_expand_selection_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

  })
}

## To be copied in the UI
# mod_expand_selection_ui("expand_selection_1")

## To be copied in the server
# mod_expand_selection_server("expand_selection_1")
