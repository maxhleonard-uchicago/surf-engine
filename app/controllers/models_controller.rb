class ModelsController < ApplicationController
  def index
    matching_models = Model.all

    @list_of_models = matching_models.order({ :created_at => :desc })

    render({ :template => "models/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_models = Model.where({ :id => the_id })

    @the_model = matching_models.at(0)

    render({ :template => "models/show.html.erb" })
  end

  def create
    the_model = Model.new
    the_model.name = params.fetch("query_name")
    the_model.make_id = params.fetch("query_make_id")
    the_model.image = params.fetch("query_image")
    the_model.webpage = params.fetch("query_webpage")

    if the_model.valid?
      the_model.save
      redirect_to("/models", { :notice => "Model created successfully." })
    else
      redirect_to("/models", { :notice => "Model failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_model = Model.where({ :id => the_id }).at(0)

    the_model.name = params.fetch("query_name")
    the_model.make_id = params.fetch("query_make_id")
    the_model.image = params.fetch("query_image")
    the_model.webpage = params.fetch("query_webpage")

    if the_model.valid?
      the_model.save
      redirect_to("/models/#{the_model.id}", { :notice => "Model updated successfully."} )
    else
      redirect_to("/models/#{the_model.id}", { :alert => "Model failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_model = Model.where({ :id => the_id }).at(0)

    the_model.destroy

    redirect_to("/models", { :notice => "Model deleted successfully."} )
  end
end
