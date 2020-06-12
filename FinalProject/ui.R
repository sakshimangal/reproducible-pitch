library(shiny)

shinyUI(fluidPage(
    titlePanel("Height Pediction"),
    sidebarLayout(
        sidebarPanel(
            helpText("Prediction of the son's height based on father's height"),
            helpText("Parameters:"),
            sliderInput(inputId = "inFh",
                        label = "Father's height (cm):",
                        value = 150,
                        min = 150,
                        max = 220,
                        step = 1),
        ),
        
        mainPanel(
            htmlOutput("pText"),
            htmlOutput("pred"),
            plotOutput("Plot", width = "70%")
        )
    )
))
