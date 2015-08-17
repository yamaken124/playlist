require 'rubygems'
require 'httparty'
    require 'socket'

class PlaylistsController < UsersController

  def after_sign_in_path_for(user)
    ranking_playlists_path
  end

#  before_action :authenticate_user!, except: :top_page
  before_action :set_playlist, only: [:show, :edit, :update, :destroy]

  def top_page
    render layout: 'top_page'
  end

  def index
    p Socket.getifaddrs.select{|x| x.name == "en0"}[2]
    @playlists = Playlist.all.order("updated_at DESC")
  end

  def show
    @playlist = Playlist.find(params[:id])
    @comments = Comment.where(playlist_id: params[:id])
    ## @user_ids をわかりやすい命名に
    ### 変数多い
    #viewで使わない変数は＠をつけない
    @status = Relationship.where(follower_id: current_user.id, followed_id: @playlist.user.id).present?
    favorite = Favorite.find_by(playlist_id: params[:id], user_id: current_user.id)
    if favorite.present?
      @condition = true
    else
      @condition = false
    end
    #インスタンスメソッドとレシーバを意識して、ここのメソッドを修正
    music = Music.new(playlist_id: params[:id])
    @http = music.movie_http
=begin
=end
  end

  def new
    @playlist = Playlist.new
  end

  def create
    playlist = Playlist.new(playlist_params)
    if playlist.save
      redirect_to playlists_path
    else
=begin
      flash[:alert] = "Title can't be blank."
=end
      render :new
    end
  end

  def edit
  end

  def update
    if @playlist.update(playlist_params)
      redirect_to playlist_path(id: params[:id])
    else
      flash[:alert] = "Can't be blank!"
      render 'edit'
    end
  end

  def destroy
    @playlist = Playlist.find(params[:id])
    @playlist.destroy
    redirect_to playlists_path
  end

  def timeline
    follows = Relationship.where(follower_id: current_user.id).pluck(:followed_id)
    @follows = User.where(id: follows)
    @playlists = Playlist.where(user_id: follows).order("updated_at DESC").limit(20)
    p @playlists
  end

  def genre
  end

  def each_genre
    @genre = params[:id]
    @playlists = Playlist.where(genre: @genre)
  end

  ## ここにも怪しげなコードがあった
  def ranking
    @playlists = Playlist.ranking(params[:date], params[:genre])
    @playlist_user_ids = @playlists.pluck(:user_id)
    playlist = Playlist.new
    #変なインスタンスメソッドを作って使用しているが、classを作ってやり直すのは時間かかるということでしのさんと話し、ここはそのままで。
    if params[:date].present?
      @title = playlist.date_ranking_title(params[:date])
    elsif params[:genre].present?
      @title = playlist.genre_ranking_title(params[:genre])
    else
      @title = "総合ランキング"
    end
  end

  private
  def playlist_params
    params.require(:playlist).permit(:user_id, :title, :comment, :genre)
  end
  
  def set_playlist
    @playlist = Playlist.find(params[:id])
  end
end
