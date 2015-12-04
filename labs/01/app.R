### Data preparation
require(readr)
require(dplyr)
require(tidyr)
require(ggplot2)
original_data = read_delim("~/Downloads/Brauer2008_DataSet1.tds", 
                           delim="\t")
cleaned_data = original_data %>%
  separate(NAME, 
           c("name", "BP", "MF", "systematic_name", "number"), 
           sep = "\\|\\|") %>%
  mutate_each(funs(trimws), name:systematic_name) %>%
  select(-number, -GID, -YORF, -GWEIGHT)  %>%
  gather(sample, expression, G0.05:U0.3) %>%
  separate(sample, c("nutrient", "rate"), sep = 1, convert = TRUE)

### App code

shinyApp(
  ui=fluidPage(
    titlePanel("Case Study"),
    fluidRow(
      column(4,
             wellPanel(
               conditionalPanel(
                 condition = "input.tabs == 'genetab'",
                 selectizeInput(inputId = "gene",
                                label = "Select gene(s)",
                                choices = sort(unique(cleaned_data$name)),
                                selected = "LEU1",
                                multiple = TRUE)
               ),
               conditionalPanel(
                 condition = "input.tabs == 'processtab'",
                 selectizeInput(inputId = "process",
                                label = "Biological process",
                                choices = sort(unique(cleaned_data$BP)),
                                selected = "leucine biosynthesis")                                
               ),
               checkboxInput(inputId = "line",
                             label = "Add line of best fit?",
                             value = FALSE)
             )
             #              ,wellPanel(
             #                sliderInput(inputId = "height",
             #                            label = "Plot height",
             #                            value = 400,
             #                            min=400, max=1000)
             #              )
      ),
      column(8,
             tabsetPanel(id = "tabs",
                         tabPanel("Gene", value = "genetab"
                                  ,plotOutput("plot1")
                                  #,uiOutput("plot3")
                         ),
                         tabPanel("Process", value = "processtab",
                                  plotOutput("plot2")
                         )
             )
      )
    )
  ),
  shinyServer(function(input, output) {
    
    output$plot1 = renderPlot({
      if(input$line){
        cleaned_data %>%
          filter(is.element(name, input$gene)) %>%
          ggplot(aes(rate, expression, color = nutrient)) +
          geom_point() + theme_bw(base_size = 14) + 
          geom_smooth(method = "lm", se = FALSE)  + 
          facet_wrap(~name)
      } else {
        cleaned_data %>%
          filter(is.element(name, input$gene)) %>%
          ggplot(aes(rate, expression, color = nutrient)) +
          geom_line() + theme_bw(base_size = 14) + 
          facet_wrap(~name + systematic_name)
      }
    })
    
    output$plot2 = renderPlot({
      if(input$line){
        cleaned_data %>%
          filter(BP == input$process) %>%
          ggplot(aes(rate, expression, color = nutrient)) +
          geom_point() + theme_bw(base_size = 14) + 
          facet_wrap(~name + systematic_name) +
          geom_smooth(method = "lm", se = FALSE)   
      } else {
        cleaned_data %>%
          filter(BP == input$process) %>%
          ggplot(aes(rate, expression, color = nutrient)) +
          geom_line() + theme_bw(base_size = 14) + 
          facet_wrap(~name + systematic_name)
      }
    })
    # if you want reactive plot heights 
    #     output$plot3 = renderUI({
    #       plotOutput("plot1", height = input$height)
    #     })
  })
)
