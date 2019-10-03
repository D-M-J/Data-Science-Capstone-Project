library(shiny)
library(shinythemes)
library(dplyr)
require(markdown)
library(tm)


shinyUI(navbarPage("Data Science Capstone Project",
                   
                   theme = shinytheme("spacelab"),
                   
                   #Tab 1
                   tabPanel(strong("Next Word Prediction"),
                            fluidPage(
                                    fluidRow(
                                            column(5, offset = 1,
                                                   h2("Please enter text:"),
                                                   textInput("text_input", "", value =  "")
                                                   # submitButton("Predict next word")
                                            ),
                                            column(5,offset = 1,
                                                   h2("Next word:"),
                                                   h4("in the order of descending probability"),
                                                   h3(strong(textOutput("predictor1")),style="color:red"),
                                                   h3(strong(textOutput("predictor2")),style="color:blue"),
                                                   h3(strong(textOutput("predictor3")),style="color:green")
                                            )
                                    )
                            )
                            
                   ),
                   
                   
                   
                   
                   #Tab 
                   tabPanel(strong("About the App"),
                            headerPanel(strong("About")),
                            mainPanel(
                                    h4("This app will predict the next word in a given sentence."),
                                    h4("The prediction algorithm was built on frequencies of word originating from blog, news and twitter texts."),
                                    h4("For the models, n-grams were generated to predict the next word based on the previous 1, 2, and 3 words tokens."),
                                    h2(""),
                                    h2(strong ("Features"),
                                       h4("- Reactive processing of input words"),
                                       h4("- Three predictions in the order of descending probability"),
                                       h4("- Fast predictions"),
                                       h5("Please note that the accuracy of the prediction is limited due to capacity and speed "),
                                       h2(""),
                                       h4("The source code files are on", a("GitHub page", href = "https://github.com/D-M-J/Data-Science-Capstone-Project.git"))
                                       
                                       
                                    )
                            )           
                   )
))       



