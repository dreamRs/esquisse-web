
application_ui <- function(req) {
  qs <- parseQueryString(req$QUERY_STRING)
  lang  <- if (has_lang(qs$lang)) {
    qs$lang
  } else {
    NULL
  }
  datamods::set_i18n(lang, packages = c("esquisse", "datamods"))
  datamods::set_i18n(lang, packages = NULL)
  page_fluid(
    title = "esquisse web app",
    theme = theme_app(),
    busy_start_up(
      loader = tags$div(
        tags$img(class = "loader_hex", src = "hex-esquisse.png"),
        tags$img(class = "loader_hex", src = "hex-esquisse.png"),
        tags$img(class = "loader_hex", src = "hex-esquisse.png")
      ),
      mode = "auto",
      timeout = 500,
      text = i18n_("Loading Esquisse..."),
      color = "#FFF",
      background = "#112446"
    ),
    useShinyjs(),
    navset_hidden(
      id = "navset",
      nav_panel_hidden(
        value = "home",
        class = "bg-primary h-100",
        tags$div(
          style = css(position = "absolute", top = "5px", left = "5px", zIndex = 10),
          tags$a(
            tags$img(src = "logo_dreamRs_couleur_blanc.png", style = css(height = "70px")),
            href = "https://www.dreamrs.fr/",
            target = "_blank"
          )
        ),
        tags$div(
          style = css(position = "absolute", top = "5px", right = "20px", zIndex = 10),
          select_lang_input("lang", selected = lang)
        ),
        home_ui("home", lang = lang)
      ),
      nav_panel_hidden(
        value = "esquisse",
        esquisse_ui(
          id = "esquisse",
          header = esquisse_header(
            .before = actionButton(
              inputId = "back_home",
              label = tagList(
                ph("arrow-left", weight = "bold", title = "Back to home"),
                "Go to data tab"
              ),
              class = "border border-white border-2 mx-1"
            ),
            .after = tagList(
              actionButton(
                inputId = "help",
                label = ph("question", height = "1.6em", weight = "bold", title = "Help")
              ),
              actionButton(
                inputId = "save_plot",
                label = tagList(
                  ph("floppy-disk", height = "1.6em", weight = "bold", title = "Save plot"),
                  "Save plot"
                ),
                class = "border border-white border-2 mx-1 pt-1"
              ),
              actionButton(
                inputId = "go_to_history",
                label = tagList(
                  "Go to history tab",
                  ph("arrow-right", weight = "bold", title = "Go to history")
                ),
                class = "border border-white border-2 mx-1"
              )
            ),
            import_data = FALSE,
            close = FALSE
          ),
          container = esquisse_container(fixed = TRUE),
          play_pause = FALSE,
          controls = c("options", "labs", "axes", "geoms", "theme", "filters", "code", "export"),
          layout_sidebar = TRUE
        )
      ),
      nav_panel_hidden(
        value = "history",
        tags$div(
          style = css(position = "absolute", top = "5px", left = "12px", zIndex = 10),
          actionButton(
            inputId = "back_to_esquisse",
            label = tagList(
              ph("arrow-left", weight = "bold", title = "Back to home"),
              "Back to esquisse"
            ),
            class = "border border-white border-2 mx-1"
          )
        ),
        history_ui("history")
      )
    )
  )
}


application_server <- function(input, output, session) {

  rv <- reactiveValues(plot_list = list())

  observeEvent(input$lang, {
    block_app()
    updateQueryString(queryString = sprintf("?lang=%s", input$lang))
    session$reload()
  }, ignoreInit = TRUE)

  data_r <- home_server("home")

  observeEvent(data_r(), nav_select("navset", "esquisse"))
  observeEvent(input$back_home, nav_select("navset", "home"))

  res_esquisse <- esquisse_server(
    id = "esquisse",
    data_rv = data_r,
    import_from = NULL
  )

  observeEvent(input$save_plot, show_modal_save_plot())
  observeEvent(input$save_this_plot, {
    # print(str(reactiveValuesToList(res_esquisse)))
    rv$plot_list[[length(rv$plot_list) + 1]] <- list(
      label = input$plot_label,
      code = res_esquisse$code_plot,
      ggobj = res_esquisse$ggobj
    )
    removeModal()
  })
  observeEvent(input$go_to_history, nav_select("navset", "history"))

  history_server(
    id = "history",
    plot_list_r = reactive({
      req(rv$plot_list)
      rv$plot_list
    })
  )
  observeEvent(input$back_to_esquisse, nav_select("navset", "esquisse"))

  observeEvent(input$help, {
    show_modal_help("help")
  })
  help_server("help")
}

