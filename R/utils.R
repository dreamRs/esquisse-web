
list_lang <- function() {
  c("al", "br", "cn", "de", "es", "fr", "gb", "ja", "kr", "mk", "pl", "pt", "tr")
}

has_lang <- function(lang) {
  isTRUE(lang %in% setdiff(list_lang(), c("br", "gb")))
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
    focusSelectedOptionOnOpen = FALSE,
    width = "90px"
  )
}



translations <- function(lang) {
  if (is.null(lang))
    return(NULL)
  translations <- list(
    fr = list(
      "Upload a file" = "Importer un fichier",
      "Copy/Paste data" = "Copier / Coller des données",
      "Import a Googlesheet" = "Importer une Googlesheet",
      "Read from URL" = "Lire depuis une URL",
      "Or use demo dataset" = "Ou utiliser des données de démo"
    ),
    de = list(
      "Upload a file" = "Eine Datei hochladen",
      "Copy/Paste data" = "Daten kopieren/einfügen",
      "Import a Googlesheet" = "Ein Googlesheet importieren",
      "Read from URL" = "Von URL lesen",
      "Or use demo dataset" = "Oder verwenden Sie den Demo-Datensatz"
    )
  )
  translations[[lang]]
}

i18n_ <- function(text) {
  i18n(text, translations = translations(getOption("i18n")))
}



