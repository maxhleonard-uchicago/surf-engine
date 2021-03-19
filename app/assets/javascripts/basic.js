function condAdd (element, clsName) {
  if (!element.classList.contains(clsName)) {
    element.classList.add(clsName);
  }
}

function condRemove (element, clsName) {
  if (element.classList.contains(clsName)) {
    element.classList.remove(clsName);
  }
}



function bookmark(board_id, user_id, action) {

  if (action == "remove") {
    
    const url = "/users/" + user_id + "/saves/" + board_id + "/delete";
    const data = {
      "user_id": user_id,
      "board_id":board_id
    };
    const params = {
      "body":data,
      "method":"POST"
    };
    fetch(url, params)  
  } else if (action == "add") {
    
    const url = "/users/" + user_id + "/saves/" + board_id + "/add";
    const data = {
      "user_id": user_id,
      "board_id":board_id
    };
    const params = {
      "body":data,
      "method":"POST"
    };
    fetch(url, params)
  }     
}

