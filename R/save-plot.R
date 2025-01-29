
show_modal_save_plot <- function() {
  showModal(modalDialog(
    title = tagList(
      "Save plot", datamods:::button_close_modal()
    ),
    size = "m",
    easyClose = TRUE,
    textInput(
      inputId = "plot_label",
      label = "Label for plot:",
      value = NA,
      width = "100%"
    ),
    footer = tagList(
      actionButton(
        inputId = "save_this_plot",
        label = "Save this plot",
        class = "btn-outline-primary w-100"
      )
    )
  ))
}
