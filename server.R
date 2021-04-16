library("shiny")

shinyServer(function(input, output) {
 
  # Create model using vehicle weight, quarter second time and transmission
  # type to preduct MPG
  
  model <- lm(mpg ~ wt + am + qsec, data=mtcars)
  
  # Create reactive element to create prediction whenever inputs change
  
  modelPred <- reactive({
      wtInput <- input$sliderWT / 1000
      qsInput <- input$sliderQS
      transInput <- as.numeric(input$transType)
      predict(model, newdata=data.frame(wt=wtInput, am=transInput, qsec=qsInput))
  })
  
  # Output plot showing new model with changed inputs
  
  output$plot <- renderPlot({
      wtInput <- input$sliderWT / 1000
      qsInput <- input$sliderQS
      transInput <- as.numeric(input$transType)
      plot(mtcars$wt, mtcars$mpg,
            ylab="Miles Per Gallon",
            xlab="Vehicle Weight in 1000 lbs",
            ylim=c(0,50),
            bty="n", pch=16)
      coefs <- coef(model)
      abline(a=coefs[1] + coefs[3]*transInput + coefs[4]*qsInput, 
             b=coefs[2], col="red", lwd=4)
      points(wtInput, modelPred(), col="blue", pch=16, cex=3)
  })
  
  # Output the predicted MPG
  
  output$pred <- renderText({
      modelPred()
  })
      
})

