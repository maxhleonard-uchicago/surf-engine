class DistancesController < ApplicationController
  def index
    matching_distances = Distance.all

    @list_of_distances = matching_distances.order({ :created_at => :desc })

    render({ :template => "distances/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_distances = Distance.where({ :id => the_id })

    @the_distance = matching_distances.at(0)

    render({ :template => "distances/show.html.erb" })
  end

  def create
    the_distance = Distance.new
    the_distance.origin = params.fetch("query_origin")
    the_distance.destination = params.fetch("query_destination")
    the_distance.distance = params.fetch("query_distance")
    the_distance.duration = params.fetch("query_duration")

    if the_distance.valid?
      the_distance.save
      redirect_to("/distances", { :notice => "Distance created successfully." })
    else
      redirect_to("/distances", { :notice => "Distance failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_distance = Distance.where({ :id => the_id }).at(0)

    the_distance.origin = params.fetch("query_origin")
    the_distance.destination = params.fetch("query_destination")
    the_distance.distance = params.fetch("query_distance")
    the_distance.duration = params.fetch("query_duration")

    if the_distance.valid?
      the_distance.save
      redirect_to("/distances/#{the_distance.id}", { :notice => "Distance updated successfully."} )
    else
      redirect_to("/distances/#{the_distance.id}", { :alert => "Distance failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_distance = Distance.where({ :id => the_id }).at(0)

    the_distance.destroy

    redirect_to("/distances", { :notice => "Distance deleted successfully."} )
  end
end
