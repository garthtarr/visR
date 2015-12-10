
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

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

})