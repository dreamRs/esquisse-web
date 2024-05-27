
home_ui <- function(id, lang = "en") {
  ns <- NS(id)
  if (is.null(lang))
    lang <- "en"
  md_intro <- sprintf("md/%s.md", lang)
  if (!file.exists(md_intro))
    md_intro <- "md/en.md"
  esquisse_container(fixed = TRUE)(
    class = "bg-primary overflow-auto",
    id = ns("container"),
    particles(config = "www/particlesjs-config.json", target_id = ns("container")),

    tags$div(
      # style = css(maxWidth = "1200px", margin = "auto"),
      style = css(
        position = "absolute",
        maxWidth = "1200px",
        top = "20px",
        left = 0,
        right = 0,
        margin = "auto"
      ),
      includeMarkdown(md_intro),
      card(
        fill = FALSE,
        navset_pill(
          header = tags$hr(),
          # footer = tags$br(),
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
            select_demo_dataset_ui(ns("demo"))
          )
        ),
        datagridOutput2(outputId = ns("grid")),
        uiOutput(outputId = ns("container_go"), class = "d-block")
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
        btn_show_data = FALSE
      )
      from_copypaste <- import_copypaste_server(
        id = "copypaste",
        trigger_return = "change",
        btn_show_data = FALSE
      )
      from_googlesheets <- import_googlesheets_server(
        id = "googlesheets",
        trigger_return = "change",
        btn_show_data = FALSE
      )
      from_url <- import_url_server(
        id = "url",
        trigger_return = "change",
        btn_show_data = FALSE
      )
      from_demo <- select_demo_dataset_server(
        id = "demo"
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
      observeEvent(from_demo$data(), {
        rv$data <- from_demo$data()
        rv$name <- from_demo$name()
        shinyjs::runjs(sprintf(
          "document.getElementById('%s').scrollIntoView();",
          session$ns("container_go")
        ))
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
            label = tagList(ph("chart-scatter"), i18n_("Go to esquisse")),
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
