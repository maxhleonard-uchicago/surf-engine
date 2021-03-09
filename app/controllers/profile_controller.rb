class ProfileController < ApplicationController

  def home
    user_id = params.fetch("user_id")
    if @current_user == nil
      redirect_to("/")
    elsif @current_user.id != user_id
      redirect_to("/")
    else
      render({:template => "profile/home.html.erb"})
    end
  end

end
