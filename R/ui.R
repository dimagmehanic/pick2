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
  
  uiOutput("login"),
  
  div(
    class = "card-container",
    
    uiOutput("card")
  )
)