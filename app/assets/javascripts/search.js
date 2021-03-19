function displayModels (){
  
  var modelSelect = document.getElementById("model");
  modelSelect.disabled = true;
  var i, L = modelSelect.options.length - 1;
  for(i = L; i >= 1; i--) {
    modelSelect.remove(i);
  }
  
  var ind = document.getElementById("make").value;
  if (ind != "-1") {
    fetch(`/makes/${ind}/models.json`)
    .then(response => response.json())
    .then((data) => {
      data.forEach(model => {
        
        var option = document.createElement("option");
        option.text = model["model"]["name"];
        option.value = model["model"]["id"];
        modelSelect.add(option);
      });
      
      modelSelect.disabled = false;
    })
  }
}


function convertWidth(sixteen) {
  if (sixteen == 0) {
    var fraction = ""
  } else if (sixteen == 2) {
    var fraction = "1/8";
  } else if (sixteen == 4) {
    var fraction = "1/4";
  } else if (sixteen == 6) {
    var fraction = "3/8";
  } else if (sixteen == 8) {
    var fraction = "1/2";
  } else if (sixteen == 10) {
    var fraction = "5/8";
  } else if (sixteen == 12) {
    var fraction = "3/4";
  } else if (sixteen == 14) {
    var fraction = "7/8";
  } else {
    var fraction = sixteen.toString() + "/16";
  }
  return fraction
}



function enableRangeField(field) {

  document.getElementById("min_" + field).disabled = !document.getElementById("min_" + field).disabled;
  document.getElementById("max_" + field).disabled = !document.getElementById("max_" + field).disabled;

}


function shopName() {
  if (document.getElementById("store").checked) {
    document.getElementById("shop_name").disabled = false;
  } else {
    document.getElementById("shop_name").disabled = true;
  }
}


function sellerDisplay(which) {
  var shopBoards = document.getElementsByClassName("shop-board");
  var individualBoards = document.getElementsByClassName("individual-board");
  if (which == "shops") {
    for (let i = 0; i < shopBoards.length; i++) {
      condRemove(shopBoards[i], "d-none");
    }
    for (let i = 0; i < individualBoards.length; i++) {
      condAdd(individualBoards[i], "d-none");
    }
  } else if (which == "individuals") {
    for (let i = 0; i < shopBoards.length; i++) {
      condAdd(shopBoards[i], "d-none");
    }
    for (let i = 0; i < individualBoards.length; i++) {
      condRemove(individualBoards[i], "d-none");
    }
  } else if (which == "both") {
    for (let i = 0; i < shopBoards.length; i++) {
      condRemove(shopBoards[i], "d-none");
    }
    for (let i = 0; i < individualBoards.length; i++) {
      condRemove(individualBoards[i], "d-none");
    }
  }
}



function sellerButtons(which) {
    shopButton = document.getElementById("shopsButton");
    individualButton = document.getElementById("individualsButton");
    bothButton = document.getElementById("bothButton");

    if (which == "shops") {
      condRemove(shopButton, "btn-secondary");
      condAdd(shopButton, "btn-primary");
      condRemove(individualButton, "btn-primary");
      condAdd(individualButton, "btn-secondary");
      condRemove(bothButton, "btn-primary");
      condAdd(bothButton, "btn-secondary");
      changeMarkers("shops");
    } else if (which == "individuals") {
      condRemove(shopButton, "btn-primary");
      condAdd(shopButton, "btn-secondary");
      condRemove(individualButton, "btn-secondary");
      condAdd(individualButton, "btn-primary");
      condRemove(bothButton, "btn-primary");
      condAdd(bothButton, "btn-secondary");
      changeMarkers("individuals");
    } else if (which == "both") {
      condRemove(shopButton, "btn-primary");
      condAdd(shopButton, "btn-secondary");
      condRemove(individualButton, "btn-primary");
      condAdd(individualButton, "btn-secondary");
      condRemove(bothButton, "btn-secondary");
      condAdd(bothButton, "btn-primary");
      changeMarkers("both");
    }
    sellerDisplay(which);
  }


function displayButtons(which) {
  listButton = document.getElementById("listButton");
  mapButton = document.getElementById("mapButton");
  cardButton = document.getElementById("cardButton");
  listDiv = document.getElementById("listDiv");
  mapDiv = document.getElementById("mapDiv");
  cardDiv = document.getElementById("cardDiv");
  if (which == "list") {
    listButton.className = "btn btn-primary data-button";
    mapButton.className = "btn btn-secondary data-button";
    cardButton.className = "btn btn-secondary data-button";
    condRemove(listDiv, "d-none");
    condAdd(mapDiv, "d-none");
    condAdd(cardDiv, "d-none");
    condRemove(cardDiv, "d-flex");
    condRemove(cardDiv, "flex-column");
  } else if (which == "map") {
    listButton.className = "btn btn-secondary data-button";
    mapButton.className = "btn btn-primary data-button";
    cardButton.className = "btn btn-secondary data-button";
    condAdd(listDiv, "d-none");
    condRemove(mapDiv, "d-none");
    condAdd(cardDiv, "d-none");
    condRemove(cardDiv, "d-flex");
    condRemove(cardDiv, "flex-column");
  } else if (which == "card") {
    listButton.className = "btn btn-secondary data-button";
    mapButton.className = "btn btn-secondary data-button";
    cardButton.className = "btn btn-primary data-button"
    condAdd(listDiv, "d-none");
    condAdd(mapDiv, "d-none");
    condRemove(cardDiv, "d-none");
    condAdd(cardDiv, "d-flex");
    condAdd(cardDiv, "flex-column");
  }
}


function listBookmark(board_id, user_id) {
  var button = document.getElementById("list_bookmark_" + board_id);
  if (button.classList.contains("unsaved")) {
    button.classList.remove("unsaved");
    button.classList.add("saved");
    button.classList.remove("btn-success");
    button.classList.add("btn-primary");
    button.innerText = "Un-save Board";
    bookmark(board_id, user_id, "add");
  } else if (button.classList.contains("saved")) {
    button.classList.remove("saved");
    button.classList.add("unsaved");
    button.classList.remove("btn-primary");
    button.classList.add("btn-success");
    button.innerText = "Save Board";
    bookmark(board_id, user_id, "remove");
  }
}

function cardBookmark(board_id, user_id) {
  var button = document.getElementById("card_bookmark_" + board_id);
  if (button.classList.contains("unsaved")) {
    button.classList.remove("unsaved");
    button.classList.add("saved");
    button.classList.remove("btn-success");
    button.classList.add("btn-primary");
    button.innerText = "-";
    bookmark(board_id, user_id, "add");
  } else if (button.classList.contains("saved")) {
    button.classList.remove("saved");
    button.classList.add("unsaved");
    button.classList.remove("btn-primary");
    button.classList.add("btn-success");
    button.innerText = "+";
    bookmark(board_id, user_id, "remove");
  }
}



function paginateCards(page) {
  page = parseInt(page);
  var cardButtons = document.getElementsByClassName("cardsButton");
  var cardPages = document.getElementsByClassName("cardsPage");
  for (let i = 0; i < cardButtons.length; i++) {
    if (cardButtons[i].classList.contains("active")) {
      var activeInd = i;
    }
  }
  
  if (page == -1) {
    var selectedButton = cardButtons[activeInd + 1];
    var selectedPage = cardPages[activeInd + 1];
  } else if (page == -2) {
    var selectedButton = cardButtons[activeInd - 1];
    var selectedPage = cardPages[activeInd - 1];
  } else {
    var selectedButton = cardButtons[page];
    var selectedPage = cardPages[page];
  }
  condRemove(cardButtons[activeInd], "active");
  condAdd(selectedButton, "active");
  if (activeInd != page) {
    cardPages[activeInd].className = "d-none cardsPage";
    selectedPage.className = "d-flex flex-row flex-wrap justify-content-around cardsPage active";
  }
  
}