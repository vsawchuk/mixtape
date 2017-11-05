class SongsController < ApplicationController
  def index
    songs = Song.all.sample(12)
    render :json => songs.as_json(only: [:id, :title, :artist, :year]), status: :ok
  end
end
