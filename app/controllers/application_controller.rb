class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end


  def load_data
    @makes = Make.all
    @shops = Shop.all
    if @current_user != nil
      @bookmarks = @current_user.bookmarks.map_relation_to_array(:board_id)
    else
      @bookmarks = Array.new
    end
  end

  def home
    load_data()
    @search = false
    @shops = Array.new
    render({:template => "home/search.html.erb"})
  end


  def test
    render({:template => "/home/test.html.erb"})
  end

  def show_shop
    shop_id = params.fetch("shop_id").to_i
    @shop = Shop.where({:id => shop_id}).first
    @boards = Board.where({:shop_id => shop_id})
    render({:template => "shops/show.html.erb"})
  end

end
