Rails.application.routes.draw do

  # Routes for the Distance resource:

  # CREATE
  post("/insert_distance", { :controller => "distances", :action => "create" })
          
  # READ
  get("/distances", { :controller => "distances", :action => "index" })
  
  get("/distances/:path_id", { :controller => "distances", :action => "show" })
  
  # UPDATE
  
  post("/modify_distance/:path_id", { :controller => "distances", :action => "update" })
  
  # DELETE
  get("/delete_distance/:path_id", { :controller => "distances", :action => "destroy" })

  #------------------------------

  # Routes for the Board resource:

  # CREATE
  post("/insert_board", { :controller => "boards", :action => "create" })
          
  # READ
  get("/boards", { :controller => "boards", :action => "index" })
  
  get("/boards/:path_id", { :controller => "boards", :action => "show" })
  
  # UPDATE
  
  post("/modify_board/:path_id", { :controller => "boards", :action => "update" })
  
  # DELETE
  get("/delete_board/:path_id", { :controller => "boards", :action => "destroy" })

  #------------------------------

  # Routes for the Shop resource:

  # CREATE
  post("/insert_shop", { :controller => "shops", :action => "create" })
          
  # READ
  get("/shops", { :controller => "shops", :action => "index" })
  
  get("/shops/:path_id", { :controller => "shops", :action => "show" })
  
  # UPDATE
  
  post("/modify_shop/:path_id", { :controller => "shops", :action => "update" })
  
  # DELETE
  get("/delete_shop/:path_id", { :controller => "shops", :action => "destroy" })

  get("/shops/:shop_id/employee", { :controller => "shops", :action => "home"})

  #------------------------------

  # Routes for the Make resource:

  # CREATE
  post("/insert_make", { :controller => "makes", :action => "create" })
          
  # READ
  get("/makes", { :controller => "makes", :action => "index" })
  
  get("/makes/:path_id", { :controller => "makes", :action => "show" })
  
  # UPDATE
  
  post("/modify_make/:path_id", { :controller => "makes", :action => "update" })
  
  # DELETE
  get("/delete_make/:path_id", { :controller => "makes", :action => "destroy" })

  #Models in json
  get("/makes/:make_id/models.json", {:controller => "jsrequests", :action => "models_by_make"})

  #------------------------------

  # Routes for the Model resource:

  # CREATE
  post("/insert_model", { :controller => "models", :action => "create" })
          
  # READ
  get("/models", { :controller => "models", :action => "index" })
  
  get("/models/:path_id", { :controller => "models", :action => "show" })
  
  # UPDATE
  
  post("/modify_model/:path_id", { :controller => "models", :action => "update" })
  
  # DELETE
  get("/delete_model/:path_id", { :controller => "models", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  get("/users/:user_id", {:controller => "profile", :action => "home"})

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  get("/", {:controller => "application", :action => "home"})

  get("/results", {:controller => "search", :action => "search"})

end
