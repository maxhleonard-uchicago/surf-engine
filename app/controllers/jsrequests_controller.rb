class JsrequestsController < ApplicationController
  
  def models_by_make
    make_id = params.fetch("make_id")
    make = Make.where({:id => make_id}).first
    models = make.models
    render json: models.to_json
  end
end