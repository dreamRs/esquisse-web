
application_ui <- function() {
  page_fluid(
    title = "esquisse web app",
    theme = bs_theme_esquisse(),# |> bs_theme_update(bg = "#112446", fg = "#FFFFFF"),
    navset_hidden(
      id = "navset",
      nav_panel_hidden(
        value = "home",
        class = "bg-primary h-100",
        home_ui("home")
      ),
      nav_panel_hidden(
        value = "esquisse",
        esquisse_ui(
          id = "esquisse",
          header = esquisse_header(close = FALSE), # hide the close button
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

  data_r <- home_server("home")

  observeEvent(data_r(), nav_select("navset", "esquisse"))

  esquisse_server(
    id = "esquisse",
    data_rv = data_r,
    import_from = NULL
  )

}

