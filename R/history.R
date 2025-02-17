
history_ui <- function(id) {
  ns <- NS(id)
  esquisse_container(fixed = TRUE)(
    class = "bg-primary overflow-auto px-5",
    tags$div(
      class = "position-relative my-4",
      actionButton(
        inputId = ns("back_to_esquisse"),
        label = tagList(
          ph("arrow-left", weight = "bold", title = "Back to home"),
          "Back to esquisse"
        ),
        class = "border border-white border-2 bg-primary text-white position-absolute start-0"
      ),
      tags$h2("Plot history", class = "text-center")
    ),
    save_multi_ggplot_ui(ns("history"))
  )
}

history_server <- function(id, plot_list_r) {
  moduleServer(
    id,
    function(input, output, session) {

      save_multi_ggplot_server(
        id = "history",
        plot_list_r = plot_list_r,
        placeholder = shinyWidgets::alert(
          status = "info",
          class = "col-12 fs-5",
          ph("info", weight = "bold", height = "2em", vertical_align = "-0.5em"),
          "There's no plot to display here, go back to esquisse and then save a plot by clicking the button on the top right.",
          "All your saved plots will be available here."
        )
      )
      
      return(list(
        back_to_esquisse = reactive(input$back_to_esquisse)
      ))
    }
  )
}
