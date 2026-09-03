get_cards <- function() {
  data.frame(
    user = c(
      "jack",
      "jack",
      "john",
      "john"
    ),
    
    name = c(
      "Movie 1",
      "Movie 2",
      "Movie 3",
      "Movie 2"
    ),
    
    image = c(
      "images/image1.jpg",
      "images/image2.jpg",
      "images/image3.jpg",
      "images/image2.jpg"
    ),
    
    rating = c(
      4.5,
      3.8,
      4.9,
      3.8
    ),
    
    review = c(
      "A really good movie.",
      "Pretty good and entertaining.",
      "Excellent! Highly recommended.",
      "Pretty good and entertaining."
    ),
    
    stringsAsFactors = FALSE
  )
}
