
application_ui <- function(req) {
  qs <- parseQueryString(req$QUERY_STRING)
  lang  <- if (has_lang(qs$lang)) {
    qs$lang
  } else {
    NULL
  }
  datamods::set_i18n(lang, packages = c("esquisse", "datamods"))
  page_fluid(
    title = "esquisse web app",
    theme = bs_theme_esquisse(),# |> bs_theme_update(bg = "#112446", fg = "#FFFFFF"),
    busy_start_up(
      loader = spin_epic("self-building-square", color = "#FFF"),
      mode = "timeout",
      timeout = 500,
      text = "Esquisse is loading...",
      color = "#FFF",
      background = "#112446"
    ),
    navset_hidden(
      id = "navset",
      nav_panel_hidden(
        value = "home",
        class = "bg-primary h-100",
        tags$div(
          style = css(position = "absolute", top = "5px", right = "5px", zIndex = 10),
          select_lang_input("lang", selected = lang)
        ),
        home_ui("home")
      ),
      nav_panel_hidden(
        value = "esquisse",
        esquisse_ui(
          id = "esquisse",
          header = esquisse_header(
            .before = actionButton(
              inputId = "back_home",
              label = ph("arrow-left", weight = "bold", title = "Back to home")
            ),
            import_data = FALSE,
            close = FALSE
          ),
          container = esquisse_container(fixed = TRUE),
          play_pause = FALSE,
          controls = c("settings", "labs", "axes", "geoms", "theme", "filters", "code", "export"),
          layout_sidebar = TRUE
        )
      )
    )
  )
}


application_server <- function(input, output, session) {

  observeEvent(input$lang, {
    updateQueryString(queryString = sprintf("?lang=%s", input$lang))
    session$reload()
  }, ignoreInit = TRUE)

  data_r <- home_server("home")

  observeEvent(data_r(), nav_select("navset", "esquisse"))
  observeEvent(input$back_home, nav_select("navset", "home"))

  esquisse_server(
    id = "esquisse",
    data_rv = data_r,
    import_from = NULL
  )

}

