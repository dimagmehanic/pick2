cards <- data.frame(
  name = c(
    "Movie 1",
    "Movie 2",
    "Movie 3"
  ),
  
  image = c(
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg"
  ),
  
  rating = c(
    4.5,
    3.8,
    4.9
  ),
  
  review = c(
    "A really good movie.",
    "Pretty good and entertaining.",
    "Excellent! Highly recommended."
  ),
  
  stringsAsFactors = FALSE
)


server <- function(input, output, session) {
  
  current <- reactiveVal(1)
  
  
  output$card <- renderUI({
    
    i <- current()
    
    card <- cards[i, ]
    
    div(
      class = "card",
      
      tags$img(
        src = card$image
      ),
      
      div(
        class = "card-info",
        
        div(
          class = "card-name",
          card$name
        ),
        
        div(
          class = "rating",
          paste0(
            "★ ",
            card$rating,
            " / 5"
          )
        ),
        
        div(
          class = "review",
          card$review
        )
      )
    )
  })
  
  
  observeEvent(input$swipe, {
    
    i <- current()
    
    direction <- input$swipe$direction
    
    print(
      paste(
        cards$name[i],
        "->",
        direction
      )
    )
    
    if (i < nrow(cards)) {
      current(i + 1)
    }
  })
  session$onSessionEnded(function() { stopApp() })
}