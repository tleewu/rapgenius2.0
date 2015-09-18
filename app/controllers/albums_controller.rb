class AlbumsController < ApplicationController
  before_action :ensure_log_in
  def new
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:messages] = "#{@album.name} created successfully!"
      redirect_to album_url(@album)
    else
      flash[:messages] = @album.errors.full_messages
      redirect_to new_album_url
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash[:messages] = @album.errors.full_messages
      redirect_to edit_album_url
    end
  end

  def destroy
    @album = Album.find(params[:id])
    if @album.nil?
      redirect_to bands_url
      return
    end
    @album.destroy
    flash[:messages] = "#{@album.name} has been deleted."
    redirect_to bands_url
  end

  private
  def album_params
    params.require(:album).permit(:band_id, :name,:style)
  end
end
