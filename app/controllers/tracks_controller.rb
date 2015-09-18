class TracksController < ApplicationController
  before_action :ensure_log_in

  def new
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:messages] = "#{@track.name} created successfully!"
      redirect_to track_url(@track)
    else
      flash[:messages] = @track.errors.full_messages
      redirect_to new_track_url
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash[:messages] = @track.errors.full_messages
      redirect_to edit_track_url
    end
  end

  def destroy
    @track = Track.find(params[:id])
    if @track.nil?
      redirect_to bands_url
      return
    end
    @track.destroy
    flash[:messages] = "#{@track.name} has been deleted."
    redirect_to bands_url
  end

  private
  def track_params
    params.require(:track).permit(:album_id, :name,:version, :lyrics)
  end
end
