
home_ui <- function(id) {
  ns <- NS(id)
  esquisse_container(fixed = TRUE)(
    class = "bg-primary overflow-auto",
    tags$div(
      style = css(maxWidth = "1200px", margin = "auto"),
      tags$h1(
        "Welcome to", "esquisse",
        class = "text-center fw-bold text-secondary mt-5"
      ),
      tags$h3(
        "by",
        tags$a("dreamRs", href = "https://www.dreamrs.fr/", target = "_blank", class = "text-secondary"),
        class = "text-center text-secondary mb-3"
      ),
      tags$p(
        class = "text-center text-secondary fs-5 w-50 mx-auto mb-3",
        "{esquisse} is an R package for creating graphs with {ggplot2},",
        "allowing you to use esquisse directly online, without having to install the package.",
        "Before creating a graph, you must first import data to be used to create a graph, or use a demo dataset."
      ),
      tags$p(
        tags$a(
          "See the code on GitHub", phosphoricons::ph("github"),
          href = "https://github.com/dreamRs/esquisse/tree/master",
          target = "_blank",
          class = "text-secondary"
        ),
        class = "text-center fs-4 mb-5"
      ),
      card(
        fill = FALSE,
        navset_pill(
          header = tags$br(),
          footer = tags$br(),
          nav_panel(
            title = i18n_("Upload a file"),
            import_file_ui(ns("file"), title = NULL, preview_data = FALSE)
          ),
          nav_panel(
            title = i18n_("Copy/Paste data"),
            import_copypaste_ui(ns("copypaste"), title = NULL)
          ),
          nav_panel(
            title = i18n_("Import a Googlesheet"),
            import_googlesheets_ui(ns("googlesheets"), title = NULL)
          ),
          nav_panel(
            title = i18n_("Read from URL"),
            import_url_ui(ns("url"), title = NULL)
          ),
          nav_spacer(),
          nav_panel(
            title = i18n_("Or use demo dataset"),
            "Select a demo dataset:"
          )
        ),
        datagridOutput2(outputId = ns("grid")),
        uiOutput(outputId = ns("container_go"))
      )
    )
  )
}

home_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      ns <- session$ns

      rv <- reactiveValues(data = list())

      from_file <- import_file_server(
        id = "file",
        trigger_return = "change",
        btn_show_data = FALSE,
        reset = reactive(input$hidden)
      )
      from_copypaste <- import_copypaste_server(
        id = "copypaste",
        trigger_return = "change",
        btn_show_data = FALSE,
        reset = reactive(input$hidden)
      )
      from_googlesheets <- import_googlesheets_server(
        id = "googlesheets",
        trigger_return = "change",
        btn_show_data = FALSE,
        reset = reactive(input$hidden)
      )
      from_url <- import_url_server(
        id = "url",
        trigger_return = "change",
        btn_show_data = FALSE,
        reset = reactive(input$hidden)
      )

      observeEvent(from_file$data(), {
        rv$data <- from_file$data()
        rv$name <- from_file$name()
      })
      observeEvent(from_copypaste$data(), {
        rv$data <- from_copypaste$data()
        rv$name <- from_copypaste$name()
      })
      observeEvent(from_googlesheets$data(), {
        rv$data <- from_googlesheets$data()
        rv$name <- from_googlesheets$name()
      })
      observeEvent(from_url$data(), {
        rv$data <- from_url$data()
        rv$name <- from_url$name()
      })


      output$grid <- renderDatagrid2({
        data <- req(rv$data)
        datagrid(
          data = data,
          theme = "default",
          colwidths = "guess",
          minBodyHeight = if (NROW(data) > 1) 400 else 30,
          summary = datamods:::construct_col_summary(data)
        ) %>%
          grid_columns(className = "font-monospace")
      })


      output$container_go <- renderUI({
        if (is.data.frame(rv$data) && nrow(rv$data) > 0) {
          actionButton(
            inputId = ns("go"),
            label = tagList(ph("chart-scatter"), "Go to esquisse"),
            class = "btn-outline-primary w-100"
          )
        } else {
          actionButton(
            inputId = ns("nogo"),
            label = "Import data to continue",
            class = "btn-outline-primary w-100 disabled"
          )
        }
      })


      observeEvent(input$go, {
        rv$final_data <- rv$data
      })

      return(reactive(rv$final_data))
    }
  )
}
