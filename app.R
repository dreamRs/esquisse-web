
# -------------------------------------------------------------------------
# esquisse web app --------------------------------------------------------
# -------------------------------------------------------------------------




# Packages ----------------------------------------------------------------

library(shiny)
library(bslib)
library(htmltools)
library(esquisse) # remotes::install_github("dreamRs/esquisse")
library(datamods) # remotes::install_github("dreamRs/datamods")
library(phosphoricons)
library(shinyWidgets)
library(shinyjs)
library(toastui)
library(shinybusy)
library(plotly)
library(R.utils)
library(particlesjs) # remotes::install_github("dreamRs/particlesjs")
library(palmerpenguins)
library(markdown)
library(sf)
library(officer)
library(styler)



# R -----------------------------------------------------------------------

sourceDirectory("R/", modifiedOnly = FALSE)



# Grid theme --------------------------------------------------------------

toastui::set_grid_theme(
  cell.normal.background = "#FFF",
  cell.normal.border = "#D8DEE9",
  cell.normal.showVerticalBorder = TRUE,
  cell.normal.showHorizontalBorder = TRUE,
  cell.header.border = "#D8DEE9",
  area.header.border = "#4C566A",
  cell.summary.border = "#D8DEE9",
  cell.summary.showVerticalBorder = TRUE,
  cell.summary.showHorizontalBorder = TRUE
)


# App ---------------------------------------------------------------------

shinyApp(
  application_ui,
  application_server
)

