class ShopsController < ApplicationController
  
  before_action :check_user
  def check_user
    shop_id = params.fetch("shop_id").to_i
    if @current_user == nil
      puts "1"
      redirect_to("/")
    elsif @current_user.shop_id != shop_id
      puts @current_user.shop_id
      puts shop_id
      redirect_to("/")
    else
      @shop = Shop.where({:id => shop_id})
    end
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
    render({:template => "/shops/home.html.erb"})
  end

  def upload
    render({:template => "/shops/upload.html.erb"})
  end

  def upload_results
    file = params[:file]
    csv_text = File.read(file.path)
    @new_boards = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
    
    render({:template => "/shops/upload_results.html.erb"})
  end

  def download_template
    send_file("#{Rails.root}/public/board_upload_template.xlsx", :disposition => 'attachment')
  end
end
