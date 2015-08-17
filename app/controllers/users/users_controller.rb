class Users::UsersController < ApplicationController
#  before_action :authenticate_user!
  layout 'application'
  def after_sign_in_path_for(user)
    playlists_path
  end

  def show
    @user = User.find_by(id: params[:id])
    @fav_count = Favorite.where(user_id: params[:id]).count
    @playlists = Playlist.where(user_id: params[:id])
    @status = Relationship.where(follower_id: current_user.id, followed_id: params[:id]).present?
    @follower_amount = Relationship.where(follower_id: params[:id]).count
  end

  def favorites
    favorites = Favorite.where(user_id: params[:id]).pluck(:playlist_id)
    @playlists = Playlist.where(id: favorites)
  end

  def make_follow
    relationship = Relationship.new(follower_id: params[:follower_id], followed_id: params[:followed_id])
    relationship.save
    redirect_to :back
  end

  def delete_follow
    relationship = Relationship.find_by(follower_id: params[:follower_id], followed_id: params[:followed_id])
    relationship.destroy
    redirect_to :back
  end

  def follow
    relationships = Relationship.where(:follower_id => params[:id]).pluck(:followed_id)
    @users = User.where(id: relationships)
  end

  def follower
    relationships = Relationship.where(:followed_id => params[:id]).pluck(:follower_id)
    @users = User.where(id: relationships)
  end

end
