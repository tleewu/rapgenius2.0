class NotesController < ApplicationController
  before_action :ensure_log_in
  before_action :ensure_correct_user, only: :destroy

  def new
    render :new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    if @note.save
      flash[:messages] = "#{current_user.email}, your comment has been posted"
      redirect_to track_url(params[:track_id])
    else
      flash[:messages] = @note.errors.full_messages
      redirect_to new_track_notes_url
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    flash[:messages] = "Comment has been deleted!"
    redirect_to track_url(params[:track_id])
  end

  private

  def note_params
    params.require(:note).permit(:comment)
  end

  def ensure_correct_user
    @note = Note.find(params[:id])
    if @note.user_id != current_user.id
      flash[:messages] = "Come on..."
      redirect_to bands_url
    end
  end

end
