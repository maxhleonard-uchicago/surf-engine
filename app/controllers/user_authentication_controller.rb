class UserAuthenticationController < ApplicationController
  # Uncomment this if you want to force users to sign in before any other actions
  # skip_before_action(:force_user_sign_in, { :only => [:sign_up_form, :create, :sign_in_form, :create_cookie] })

  def sign_in_form
    render({ :template => "user_authentication/sign_in.html.erb" })
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
        if user.employee 
          redirect_to("/shops/#{user.shop_id}/employee")
        else
          redirect_to("/users/#{user.id}", { :notice => "Signed in successfully." })
        end
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end

  def destroy_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })
  end

  def sign_up_form
    render({ :template => "user_authentication/sign_up.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")

    is_employee = params.fetch("employee").to_i
    if is_employee == 1
      store_id = params.fetch("store_id")
      store_code = params.fetch("store_code")
      this_store = Shop.where({:id => store_id})
      if this_store.count != 1
        redirect_to("/user_sign_up", { :alert => "Store credentials incorrect"})
      else
        this_store = this_store.first
      end

      if store_code != this_store.verification
        redirect_to("/user_sign_up", { :alert => "Store credentials incorrect"})
      else
        @user.employee = true
        @user.shop_id = store_id
      end
    else
      @user.employee = false
    end
    save_status = @user.save

    if save_status == true
      session[:user_id] = @user.id
      if @user.employee
        redirect_to("/shops/#{@user.shop_id}/employee")
      else
        redirect_to("/users/#{@user.id}", { :notice => "User account created successfully."})
      end
    else
      redirect_to("/user_sign_up", { :alert => "User account failed to create successfully."})
    end
  end
    
  def edit_profile_form
    render({ :template => "user_authentication/edit_profile.html.erb" })
  end

  def update
    @user = @current_user
    @user.email = params.fetch("query_email")
    @user.password = params.fetch("query_password")
    @user.password_confirmation = params.fetch("query_password_confirmation")
    @user.first_name = params.fetch("query_first_name")
    @user.last_name = params.fetch("query_last_name")
    
    if @user.valid?
      @user.save

      redirect_to("/", { :notice => "User account updated successfully."})
    else
      render({ :template => "user_authentication/edit_profile_with_errors.html.erb" })
    end
  end

  def destroy
    @current_user.destroy
    reset_session
    
    redirect_to("/", { :notice => "User account cancelled" })
  end
 
end
