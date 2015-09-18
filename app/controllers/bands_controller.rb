class BandsController < ApplicationController
  before_action :ensure_log_in
  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band)
    else
      flash[:messages] = "Please input a name for the band."
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      flash[:messages] = @band.errors.full_messages
      redirect_to edit_band_url
    end
  end

  def destroy
    @band = Band.find(params[:id])
    if @band.nil?
      redirect_to bands_url
      return
    end
    @band.destroy
    flash[:messages] = "#{@band.name} has been deleted."
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end
