class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    flash.now[:success] = t('flash_message.created', item: Comment.model_name.human)
  end

  def show
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to diary_comment_path(@comment.diary, @comment), success: t('flash_message.updated', item: Comment.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(diary_id: params[:diary_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
