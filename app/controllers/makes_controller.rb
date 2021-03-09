class MakesController < ApplicationController
  def index
    matching_makes = Make.all

    @list_of_makes = matching_makes.order({ :created_at => :desc })

    render({ :template => "makes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_makes = Make.where({ :id => the_id })

    @the_make = matching_makes.at(0)

    render({ :template => "makes/show.html.erb" })
  end

  def create
    the_make = Make.new
    the_make.name = params.fetch("query_name")
    the_make.webpage = params.fetch("query_webpage")
    the_make.logo = params.fetch("query_logo")

    if the_make.valid?
      the_make.save
      redirect_to("/makes", { :notice => "Make created successfully." })
    else
      redirect_to("/makes", { :notice => "Make failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_make = Make.where({ :id => the_id }).at(0)

    the_make.name = params.fetch("query_name")
    the_make.webpage = params.fetch("query_webpage")
    the_make.logo = params.fetch("query_logo")

    if the_make.valid?
      the_make.save
      redirect_to("/makes/#{the_make.id}", { :notice => "Make updated successfully."} )
    else
      redirect_to("/makes/#{the_make.id}", { :alert => "Make failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_make = Make.where({ :id => the_id }).at(0)

    the_make.destroy

    redirect_to("/makes", { :notice => "Make deleted successfully."} )
  end
end
