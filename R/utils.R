
theme_app <- function() {
  bs_theme_esquisse() |>
    bs_add_rules(
      c(
        # Virtual Select
        ".vscomp-toggle-button { @extend .btn }",
        ".vscomp-toggle-button { @extend .btn-outline-primary }",
        ".vscomp-toggle-button { @extend .text-start }",
        ".vscomp-arrow::after { @extend .border-dark }",
        ".vscomp-arrow::after { @extend .border-start-0 }",
        ".vscomp-arrow::after { @extend .border-top-0 }",
        ".vscomp-option:hover { @extend .bg-primary }",
        ".vscomp-option  { @extend .bg-light }",
        ".vscomp-search-wrapper { @extend .bg-light }",
        ".vscomp-toggle-all-label { @extend .bg-light }",

        # Title
        ".title-app { @extend .text-center; @extend .fw-bold; @extend .text-secondary; @extend .mt-5 }",
        ".title-app { font-family: 'Annie Use Your Telescope', handwriting; font-size: 3.5rem; }",
        ".subtitle-app { @extend .text-center; @extend .text-secondary; @extend .mb-3 }",
        ".introduction { @extend .text-center; @extend .text-secondary; @extend .fs-5; @extend .w-50; @extend .mx-auto; @extend .mb-3 }",
        ".link-github { @extend .text-center; @extend .fs-4; @extend .mb-5 }"
      )
    )
}



block_app <- function() {
  insertUI(
    selector = "body",
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
          width = "300px",
          height = "220px",
          color = "#FFF",
          top = "50%",
          left = "50%",
          margin = "-110px 0 0 -150px",
          padding = "20px",
          borderRadius = "4px",
          textAlign = "center"
        ),
        tags$img(
          src = "logo.png",
          style = css(height = "200px")
        ),
        "Reloading Esquisse..."
      )
    )
  )
}
