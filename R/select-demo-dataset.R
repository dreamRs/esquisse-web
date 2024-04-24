

select_demo_dataset_ui <- function(id) {
  ns <- NS(id)
  tagList(
    tags$h4(i18n_("Select a demo dataset:")),
    card_demo_dataset(
      title = "palmerpenguins: Palmer Archipelago (Antarctica) Penguin Data",
      "Size measurements, clutch observations, and blood isotope ratios for adult foraging Adélie, Chinstrap,",
      "and Gentoo penguins observed on islands in the Palmer Archipelago near Palmer Station, Antarctica.",
      "Data were collected and made available by Dr. Kristen Gorman and the Palmer Station Long Term Ecological Research (LTER) Program.",
      good_for = c("histogram", "scatter plot", "bar plot", "boxplot"),
      source = "https://allisonhorst.github.io/palmerpenguins/",
      inputId = ns("palmerpenguins")
    ),
    card_demo_dataset(
      title = "Fuel economy data from 1999 to 2008 for 38 popular models of cars",
      "This dataset contains a subset of the fuel economy data that the EPA makes available on https://fueleconomy.gov/.",
      "It contains only models which had a new release every year between 1999 and 2008 - this was used as a proxy for the popularity of the car.",
      good_for = c("histogram", "scatter plot", "bar plot", "boxplot"),
      source = "https://ggplot2.tidyverse.org/reference/mpg.html",
      inputId = ns("mpg")
    ),
    card_demo_dataset(
      title = "Temperature data for France",
      "This dataset contains smoothed temperature data for France over the period 2019-2024, including low, high and average for 2019-2023 period.",
      good_for = c("line chart", "area chart"),
      source = "https://data.enedis.fr",
      inputId = ns("temperatures")
    ),
    card_demo_dataset(
      title = "French population by sex and age",
      "Population estimates by sex and age on January 1ᵉʳ, 2024: departmental comparisons.",
      good_for = c("maps", "histogram"),
      source = "https://www.insee.fr/fr/statistiques/2012692#tableau-TCRD_021_tab1_departements",
      inputId = ns("population_fr")
    )
  )
}

select_demo_dataset_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {

      rv <- reactiveValues(data = NULL, name = NULL)

      observeEvent(input$palmerpenguins, {
        rv$data <- palmerpenguins::penguins
        rv$name <- "palmerpenguins::penguins"
      })

      observeEvent(input$mpg, {
        rv$data <- ggplot2::mpg
        rv$name <- "ggplot2::mpg"
      })

      observeEvent(input$temperatures, {
        rv$data <- readRDS("datas/temperatures.rds")
        rv$name <- "temperatures"
      })

      observeEvent(input$population_fr, {
        rv$data <- readRDS("datas/population_fr.rds")
        rv$name <- "population_fr"
      })

      return(list(
        data = reactive(rv$data),
        name = reactive(rv$name)
      ))
    }
  )
}

card_demo_dataset <- function(title, ..., good_for = NULL, source = NULL, inputId) {
  tags$div(
    class = "card mb-3",
    tags$div(
      class = "card-body",
      tags$h5(class = "card-title", title),
      tags$p(
        class = "card-text",
        ...,
        # tags$br(),
        fluidRow(
          column(
            width = 6,
            tags$b(ph("thumbs-up"), i18n_("Good for:")), paste(good_for, collapse = ", "),
            tags$br(),
            tags$b(ph("link"), i18n_("Source:")), tags$a(source, href = source, target = "_blank")
          ),
          column(
            width = 6,
            class = "d-flex justify-content-end",
            actionButton(
              inputId = inputId,
              label = tagList(ph("arrow-circle-right"), i18n_("Select this dataset")),
              class = "btn-outline-primary"
            )
          )
        )
      )
    )
  )
}
