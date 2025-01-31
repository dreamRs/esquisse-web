
history_ui <- function(id) {
  ns <- NS(id)
  esquisse_container(fixed = TRUE)(
    class = "bg-primary overflow-auto px-5",
    tags$h2("Plot history", class = "text-center my-4"),
    save_multi_ggplot_ui(ns("history"))
  )
}

history_server <- function(id, plot_list_r) {
  moduleServer(
    id,
    function(input, output, session) {

      save_multi_ggplot_server(
        id = "history",
        plot_list_r = plot_list_r
      )

    }
  )
}
