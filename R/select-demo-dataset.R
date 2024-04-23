

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
