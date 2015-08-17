class Users::RelationshipsController < ApplicationController

  def create
    relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:user_id])
    relationship.save
    redirect_to :back
  end

  def destroy
    relationship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
    relationship.destroy
    redirect_to :back
  end

end
