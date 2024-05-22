
show_modal_help <- function(id) {
  showModal(modalDialog(
    title = tagList(
      "Help", datamods:::button_close_modal()
    ),
    size = "xl",
    easyClose = TRUE,
    footer = NULL,
    help_ui(id)
  ))
}


help_ui <- function(id) {
  ns <- NS(id)
  help_files <- list.files("help/", pattern = "md$")
  tagList(
    virtualSelectInput(
      inputId = ns("topic"),
      label = "Select a topic:",
      choices = setNames(
        help_files,
        gsub("-", " ", tools::file_path_sans_ext(help_files), fixed = TRUE)
      ),
      width = "100%"
    ),
    uiOutput(outputId = ns("md"), class = "esquisse-help")
  )
}

help_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      output$md <- renderUI({
        includeMarkdown(path = file.path("help", input$topic))
      })

    }
  )
}

