let startX = 0;
let startY = 0;

let currentX = 0;
let currentY = 0;

let dragging = false;


function getCard() {
  return document.querySelector(".card");
}


/* Start dragging */

document.addEventListener("pointerdown", function(e) {

  const card = getCard();

  if (!card || !card.contains(e.target)) {
    return;
  }

  dragging = true;

  startX = e.clientX;
  startY = e.clientY;

  card.setPointerCapture(e.pointerId);
});


/* Drag */

document.addEventListener("pointermove", function(e) {

  if (!dragging) {
    return;
  }

  const card = getCard();

  if (!card) {
    return;
  }

  currentX = e.clientX - startX;
  currentY = e.clientY - startY;

  const rotation = currentX / 15;

  card.style.transform =
    `translate(${currentX}px, ${currentY}px)
     rotate(${rotation}deg)`;
});


/* Release */

document.addEventListener("pointerup", function() {

  if (!dragging) {
    return;
  }

  dragging = false;

  const card = getCard();

  if (!card) {
    return;
  }

  const threshold = 120;

  let direction = null;


  if (currentX > threshold) {
    direction = "right";
  } 
  else if (currentX < -threshold) {
    direction = "left";
  } 
  else if (currentY < -threshold) {
    direction = "up";
  } 
  else if (currentY > threshold) {
    direction = "down";
  }


  if (direction) {

    card.style.transition =
      "transform 0.3s ease";

    let x = 0;
    let y = 0;

    if (direction === "right") x = 1000;
    if (direction === "left")  x = -1000;
    if (direction === "up")    y = -1000;
    if (direction === "down")  y = 1000;

    card.style.transform =
      `translate(${x}px, ${y}px)
       rotate(${x / 15}deg)`;


    setTimeout(function() {

      Shiny.setInputValue(
        "swipe",
        {
          direction: direction,
          time: Date.now()
        },
        {
          priority: "event"
        }
      );

    }, 300);

  } 
  else {

    card.style.transition =
      "transform 0.2s ease";

    card.style.transform =
      "translate(0, 0) rotate(0)";
  }


  currentX = 0;
  currentY = 0;
});