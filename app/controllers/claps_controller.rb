class ClapsController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @clap = @diary.claps.find_or_initialize_by(user_id: current_user.id)
    if @clap.count < 10
      @clap.increment!(:count)
      @clap.save!
    end
  end
end