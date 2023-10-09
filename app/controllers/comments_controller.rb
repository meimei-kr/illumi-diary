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
  end

  def update
    if @comment.update(comment_params)
      redirect_to diary_comment_path(@comment.diary, @comment)
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
