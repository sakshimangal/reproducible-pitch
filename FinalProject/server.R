library(shiny)
library(UsingR)
library(dplyr)
library(ggplot2)

# 1st step: Pass inches to cm


shinyServer(function(input, output) {
    fs <- father.son
    fs <- fs %>% mutate(fheight = fheight * 2.54,
                        sheight = sheight * 2.54)
    # linear model
    modelFit <- lm(sheight ~ fheight, data = fs)
    
    output$pText <- renderText({
        paste("Father's height is",
              strong(round(input$inFh, 1)),
              "cm, then:")
    })
    output$pred <- renderText({
        df <- data.frame(fheight=input$inFh)
        ch <- predict(modelFit, newdata=df)
        kid <- paste0("son's predicted height is going to be around ",
               em(strong(round(ch))),
               " cm"
        )
    })
    output$Plot <- renderPlot({
        df <- data.frame(fheight=input$inFh)
        ch <- predict(modelFit, newdata=df)
        yvals <- c("Father", "Son")
        df <- data.frame(
            x = factor(yvals, levels = yvals, ordered = TRUE),
            y = c(input$inFh, ch))
        ggplot(df, aes(x=x, y=y, color=c("Grey", "green"), fill=c("Grey", "green"))) +
            geom_bar(stat="identity", width=0.5) +
            xlab("") +
            ylab("Height (cm)") +
            theme_minimal() +
            theme(legend.position="none")
    })
})
