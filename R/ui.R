ui <- fluidPage(
  
  tags$head(
    
    tags$link(
      rel = "stylesheet",
      href = "css/style.css"
    ),
    
    tags$script(
      src = "js/swipe.js"
    )
  ),
  
  div(
    class = "card-container",
    
    uiOutput("card")
  ),
  
)