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

  def add_bookmark
    if @current_user != nil
      user_id = params.fetch("user_id").to_i
      board_id = params.fetch("board_id").to_i
      if user_id == @current_user.id
        b = Bookmark.new
        b.user_id = user_id
        b.board_id = board_id
        b.save
      end
    end
  end

  def delete_bookmark
    if @current_user != nil
      user_id = params.fetch("user_id").to_i
      board_id = params.fetch("board_id").to_i
      if user_id == @current_user.id
        b = Bookmark.where({:user_id => user_id, :board_id => board_id}).first
        b.destroy
      end
    end
  end


end
