class Users::FavoritesController < ApplicationController

  def create
    favorite = Favorite.new(playlist_id: params[:playlist_id], user_id: params[:user_id])
    if favorite.save
      redirect_to :back
    else
      flash[:alert] = "Can't make favorite."
      redirect_to :back
    end
  end

  def destroy
    favorite = Favorite.find_by(playlist_id: params[:playlist_id], user_id: params[:user_id])
    if favorite.destroy
      redirect_to :back
    else
      flash[:alert] = "Can't make favorite."
      redirect_to :back
    end
  end

end
