class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    flash.now[:success] = t('flash_message.created', item: Comment.model_name.human)
    # 暗黙的にcreate.turbo_stream.erbを呼び出す
  end

  def update
    if @comment.update(comment_params)
      flash.now[:success] = t('flash_message.updated', item: Comment.model_name.human)
      # 暗黙的にupdate.turbo_stream.erbを呼び出す
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    flash.now[:success] = t('flash_message.destroyed', item: Comment.model_name.human)
    # 暗黙的にdestroy.turbo_stream.erbを呼び出す
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(diary_id: params[:diary_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
