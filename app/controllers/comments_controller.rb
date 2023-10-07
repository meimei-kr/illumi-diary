class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to diary_path(comment.diary), success: t('defaults.flash_message.created', item: Comment.model_name.human)
    else
      redirect_to diary_path(comment.diary), danger: t('defaults.flash_message.not_created', item: Comment.model_name.human)
    end
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy!
    redirect_to diary_path(comment.diary), success: t('defaults.flash_message.destroy', item: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(diary_id: params[:diary_id])
  end
end
