
list_lang <- function() {
  c("al", "cn", "de", "es", "fr", "en", "ja", "kr", "mk", "pl", "pt", "tr")
}

has_lang <- function(lang) {
  isTRUE(lang %in% setdiff(list_lang(), c("br", "gb")))
}

select_lang_input <- function(inputId, selected = NULL) {
  if (is.null(selected))
    selected <- "en"
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
      "Loading Esquisse..." = "Chargement d'Esquisse...",
      "Upload a file" = "Importer un fichier",
      "Copy/Paste data" = "Copier / Coller des données",
      "Import a Googlesheet" = "Importer une Googlesheet",
      "Read from URL" = "Lire depuis une URL",
      "Or use demo dataset" = "Ou utiliser des données de démo",
      "Select a demo dataset:" = "Sélectionnez un jeu de données :",
      "Source:" = "Source :",
      "Good for:" = "Bien pour :",
      "Select this dataset" = "Sélectionner ces données",
      "Go to Esquisse" = "Continuer dans Esquisse",
      "Import data to continue" = "Importez des données pour continuer"
    ),
    de = list(
      "Loading Esquisse..." = "Loading Esquisse...",
      "Upload a file" = "Eine Datei hochladen",
      "Copy/Paste data" = "Daten kopieren/einfügen",
      "Import a Googlesheet" = "Ein Googlesheet importieren",
      "Read from URL" = "Von URL lesen",
      "Or use demo dataset" = "Oder verwenden Sie den Demo-Datensatz",
      "Select a demo dataset:" = "Wählen Sie einen Demo-Datensatz aus:",
      "Source:" = "Quelle :",
      "Good for:" = "Gut für :",
      "Select this dataset" = "Wählen Sie diesen Datensatz",
      "Go to Esquisse" = "Go to Esquisse",
      "Import data to continue" = "Daten importieren, um fortzufahren"
    )
  )
  translations[[lang]]
}

i18n_ <- function(text) {
  i18n(text, translations = translations(getOption("i18n")))
}
