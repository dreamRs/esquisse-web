
list_lang <- function() {
  c("al", "br", "cn", "de", "es", "fr", "gb", "ja", "kr", "mk", "pl", "pt", "tr")
}

has_lang <- function(lang) {
  isTRUE(lang %in% list_lang())
}

select_lang_input <- function(inputId, selected = NULL) {
  if (is.null(selected))
    selected <- "gb"
  choices <- lapply(
    X = list_lang(),
    FUN = function(value) {
      label <- tags$div(
        tags$img(src = sprintf("i18n/%s.svg", value), style = "height:16px;"),
        value
      )
      list(
        label = htmltools::doRenderTags(label),
        value = value
      )
    }
  )
  virtualSelectInput(
    inputId = "lang",
    label = NULL,
    choices = choices,
    selected = selected,
    html = TRUE,
    width = "90px"
  )
}
