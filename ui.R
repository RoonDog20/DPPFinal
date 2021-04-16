library("shiny")

shinyUI(fluidPage(
     titlePanel("Predict MPG from Vehicle Weight, Transmission & 1/4 Mile Time"),
     p("April 14, 2021"),
     sidebarLayout(
          sidebarPanel(
              sliderInput("sliderWT", "What is the vehicle weight in lbs?", 
                          min=1500, max=5500, value=3500),
              sliderInput("sliderQS", "Whit is the quarter mile time in secs?",
                          min=14, max=23, value=18.5, step=0.1),
              radioButtons("transType", "What is the transmission type?", 
                           choiceNames = c("Automatic", "Manual"),
                           choiceValues = c("0", "1")),
              br(),
              br(),
              p("This shiny app attempts to predict a vehicle's MPG vased on ",
                "it's weight, quarter mile time in seconds and transmission ",
                "type using a linear model created from the mtcars dataset.")
          ),
          mainPanel(
            h3("Plot of mpg by vehicle weight for specific quarter mile time ",
               "and transmission type"),
            plotOutput("plot"),
            h4("Predicted MPG:"),
            textOutput("pred")
          )
     ),
     a("Link to GitHub repository", href="https://github.com/RoonDog20/DPPFinal") 
))