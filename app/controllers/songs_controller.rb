class SongsController < ApplicationController
  include ApplicationHelper # for duration converters

  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @songs = Song.tagged_with params[:tag]
    else
      @songs = Song.all.sort_by{ |s| s.artist.name }
    end
  end

  def show
  end

  def new
    @song = Song.new
  end

  def edit
  end

  def create
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to songs_path, notice: 'Song was successfully created.' }
        format.json { render :show, status: :created, location: @song }
      else
        format.html { render :new }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to songs_path, notice: 'Song was successfully updated.' }
        format.json { render :show, status: :ok, location: @song }
      else
        format.html { render :edit }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song.destroy
    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_params
      params[:duration] = duration_from_human(params[:duration])
      params.require(:song).permit(:artist_id, :duration, :tag_list, :title)
    end
end
