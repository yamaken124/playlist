class Users::MusicsController < ApplicationController
#  before_action :authenticate_user!
 
  def new
    @keyword = params[:keyword]
    fixed_keyword = URI.encode_www_form_component(@keyword)
    api_key = ENV['API_KEY']
    search_http = "https://www.googleapis.com/youtube/v3/search?key=#{api_key}&part=id,snippet&type=video&maxResults=20&prettyprint=true&q=#{fixed_keyword}"
    if params[:nextPageToken] != nil
      next_http = search_http << "&pageToken=" << params[:nextPageToken]
      @response = HTTParty.get(next_http)
      @nextPageToken = @response["nextPageToken"]
      @prevPageToken = @response["prevPageToken"]
    elsif params[:prevPageToken] != nil
      prev_http = search_http << "&pageToken=" << params[:prevPageToken]
      @response = HTTParty.get(prev_http)
      @nextPageToken = @response["nextPageToken"]
      @prevPageToken = @response["prevPageToken"]
    else
      @response = HTTParty.get(search_http)
      @nextPageToken = @response["nextPageToken"]
      @prevPageToken = @response["prevPageToken"]
    end
    @all_response = @response["items"]
    @playlist = Playlist.find(params[:playlist_id])
    @music = Music.new
    @musics = Music.where(playlist_id: params[:playlist_id])
    @musics_urls = @musics.pluck(:url)
  end

  def search
    p params.permit(:keyword)
    redirect_to new_playlist_music_path(params.permit(:keyword))
  end

  def create
    # music_params使う必要ある？
    music = Music.new(music_params)
    music.save
    redirect_to :back
  end

  def destroy
    music = Music.find(params[:music_id])
    music.destroy
    redirect_to :back
  end

  private

  def music_params
    params.require(:music).permit(:playlist_id, :title, :url)
  end

  def search_params
    params.require(:search).permit(:keyword)
  end

end
