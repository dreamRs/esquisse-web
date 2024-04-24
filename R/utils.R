
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
