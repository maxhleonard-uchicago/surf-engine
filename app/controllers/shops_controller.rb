class ShopsController < ApplicationController
  def index
    matching_shops = Shop.all

    @list_of_shops = matching_shops.order({ :created_at => :desc })

    render({ :template => "shops/index.html.erb" })
  end

  def check_user(shop_id)
    if @current_user == nil
      return false
    elsif @current_user.shop_id != shop_id
      return false
    else
      return true
    end
  end

  def show
    the_id = params.fetch("path_id")

    matching_shops = Shop.where({ :id => the_id })

    @the_shop = matching_shops.at(0)

    render({ :template => "shops/show.html.erb" })
  end

  def create
    the_shop = Shop.new
    the_shop.name = params.fetch("query_name")
    the_shop.address = params.fetch("query_address")
    the_shop.website = params.fetch("query_website")
    the_shop.logo = params.fetch("query_logo")

    if the_shop.valid?
      the_shop.save
      redirect_to("/shops", { :notice => "Shop created successfully." })
    else
      redirect_to("/shops", { :notice => "Shop failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_shop = Shop.where({ :id => the_id }).at(0)

    the_shop.name = params.fetch("query_name")
    the_shop.address = params.fetch("query_address")
    the_shop.website = params.fetch("query_website")
    the_shop.logo = params.fetch("query_logo")

    if the_shop.valid?
      the_shop.save
      redirect_to("/shops/#{the_shop.id}", { :notice => "Shop updated successfully."} )
    else
      redirect_to("/shops/#{the_shop.id}", { :alert => "Shop failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_shop = Shop.where({ :id => the_id }).at(0)

    the_shop.destroy

    redirect_to("/shops", { :notice => "Shop deleted successfully."} )
  end

  def home
    shop_id = params.fetch("shop_id").to_i
    if !check_user(shop_id)
      redirect_to("/")
    else
      @shop = Shop.where({:id => shop_id}).first
      render({:template => "shops/home.html.erb"})
    end
  end


end
