active_users <- reactiveVal(character())

server <- function(input, output, session) {
  
  username <- reactiveVal(NULL)
  
  current <- reactiveVal(1)
  
  finished <- reactiveVal(FALSE)
  
  # Login screen
  
  output$login <- renderUI({
    
    if (!is.null(username())) {
      return(NULL)
    }
    
    div(
      id = "login",
      
      textInput(
        "username",
        "Username:"
      ),
      
      actionButton(
        "start",
        "Start"
      )
    )
  })
  
  
  # Start button
  
  observeEvent(input$start, {
    
    req(input$username)
    
    name <- trimws(input$username) |> tolower()
    
    if (name == "") {
      return()
    }
    
    if (name %in% active_users()) {
      showNotification(
        "This username is already being used.",
        type = "error"
      )
      
      return()
    }
    
    active_users(
      c(active_users(), name)
    )
    
    username(name)
     
    current(1)
    
    finished(FALSE)
  
  })
  
  
  # Card
  
  output$card <- renderUI({
    
    req(username())
    
    if (finished()) {
      return(NULL)
    }
    
    i <- current()
    
    user_cards <- get_cards() %>% filter(user == username())
    
    if (nrow(user_cards) == 0 || i > nrow(user_cards)) {
      return(
        div(
          "No cards found for this username."
        )
      )
    }
    
    card <- user_cards[i, ]
    
    
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
  
  
  # Swipe
  
  observeEvent(input$swipe, {
    
    req(username())
    
    user_cards <- get_cards() %>% filter(user == username())
    
    i <- current()
    
    direction <- input$swipe$direction
    
    
    print(
      paste(
        username(),
        user_cards$name[i],
        "->",
        direction
      )
    )
    
    
    if (i < nrow(user_cards)) {
      current(i + 1)
    } else {
      finished(TRUE)
    }
    
  })
  
  session$onSessionEnded(function() {
    
    name <- isolate(username())
    
    if (!is.null(name)) {
      
      active_users(
        setdiff(isolate(active_users()), name)
      )
      
    }
    
  })
}