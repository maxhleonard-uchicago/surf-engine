class BoardsController < ApplicationController
  def index
    matching_boards = Board.all

    @list_of_boards = matching_boards.order({ :created_at => :desc })

    render({ :template => "boards/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_boards = Board.where({ :id => the_id })

    @the_board = matching_boards.at(0)

    render({ :template => "boards/show.html.erb" })
  end

  def create
    the_board = Board.new
    the_board.model_id = params.fetch("query_model_id")
    the_board.length = params.fetch("query_length")
    the_board.width = params.fetch("query_width")
    the_board.thickness = params.fetch("query_thickness")
    the_board.liters = params.fetch("query_liters")
    the_board.tail = params.fetch("query_tail")
    the_board.fin_config = params.fetch("query_fin_config")
    the_board.fin_system = params.fetch("query_fin_system")
    the_board.construction = params.fetch("query_construction")
    the_board.image = params.fetch("query_image")
    the_board.shop_id = params.fetch("query_shop_id")
    the_board.individual_id = params.fetch("query_individual_id")
    the_board.owner_is_shop = params.fetch("query_owner_is_shop", false)
    the_board.condition = params.fetch("query_condition")
    the_board.artwork = params.fetch("query_artwork", false)
    the_board.price = params.fetch("query_price")
    the_board.notes = params.fetch("query_notes")

    if the_board.valid?
      the_board.save
      redirect_to("/boards", { :notice => "Board created successfully." })
    else
      redirect_to("/boards", { :notice => "Board failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_board = Board.where({ :id => the_id }).at(0)

    the_board.model_id = params.fetch("query_model_id")
    the_board.length = params.fetch("query_length")
    the_board.width = params.fetch("query_width")
    the_board.thickness = params.fetch("query_thickness")
    the_board.liters = params.fetch("query_liters")
    the_board.tail = params.fetch("query_tail")
    the_board.fin_config = params.fetch("query_fin_config")
    the_board.fin_system = params.fetch("query_fin_system")
    the_board.construction = params.fetch("query_construction")
    the_board.image = params.fetch("query_image")
    the_board.shop_id = params.fetch("query_shop_id")
    the_board.individual_id = params.fetch("query_individual_id")
    the_board.owner_is_shop = params.fetch("query_owner_is_shop", false)
    the_board.condition = params.fetch("query_condition")
    the_board.artwork = params.fetch("query_artwork", false)
    the_board.price = params.fetch("query_price")
    the_board.notes = params.fetch("query_notes")

    if the_board.valid?
      the_board.save
      redirect_to("/boards/#{the_board.id}", { :notice => "Board updated successfully."} )
    else
      redirect_to("/boards/#{the_board.id}", { :alert => "Board failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_board = Board.where({ :id => the_id }).at(0)

    the_board.destroy

    redirect_to("/boards", { :notice => "Board deleted successfully."} )
  end
end
