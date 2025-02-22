
theme_app <- function() {
  bs_theme_esquisse() |>
    bs_add_rules(sass::sass_file("www/styles.scss"))
}



block_app <- function() {
  insertUI(
    selector = "body",
    immediate = TRUE,
    ui = tags$div(
      style = css(
        backgroundColor = "#112446",
        zIndex = 1500,
        position = "fixed",
        top = 0,
        bottom = 0,
        right = 0,
        left = 0
      ),
      tags$div(
        style = css(
          position = "absolute",
          width = "600px",
          height = "220px",
          color = "#FFF",
          top = "50%",
          left = "50%",
          margin = "-110px 0 0 -300px",
          padding = "20px",
          borderRadius = "4px",
          textAlign = "center"
        ),
        tags$div(
          tags$img(class = "loader_hex", src = "hex-esquisse.png"),
          tags$img(class = "loader_hex", src = "hex-esquisse.png"),
          tags$img(class = "loader_hex", src = "hex-esquisse.png")
        ),
        "Reloading Esquisse..."
      )
    )
  )
}


merge_codes <- function(code_plot, code_filters, nm_dat = "data") {
  # browser()
  if (identical(code_filters, nm_dat))
    return(code_plot)
  code <- gsub(
    x = code_plot,
    replacement = " ggplot()",
    pattern = sprintf("ggplot(%s)", nm_dat),
    fixed = TRUE
  )
  code <- paste(code_filters, code, sep = " %>%\n")
  paste(as.character(style_text(code)), collapse = "\n")
}



show_modal_color_blindness <- function(ggobj) {
  showModal(modalDialog(
    title = tagList(
      "Check color blindness", datamods:::button_close_modal()
    ),
    size = "xl",
    easyClose = TRUE,
    footer = NULL,
    tags$p(
      "Color blindness is color vision deficiency, which means people with color blindness may be not aware of differences",
      "among colors that are obvious to the people without it.",
      "Output below is rendered via the Color vision deficiency (CVD) simulator from package",
      tags$a("colorBlindness", href = "https://cran.r-project.org/package=colorBlindness", target = "_blank")
    ),
    renderPlot({
      cvdPlot(ggobj)
    }, height = 600)
  ))
}


