class DiariesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_diary, only: %i[ show edit update destroy complete ]

  # GET /diaries
  def index
    @diaries = Diary.includes(:user).where(allow_publication: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /diaries/1
  def show
    @comment = Comment.new
    @comments = @diary.comments.includes(:user).order(created_at: :desc)
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries
  def create
    @diary = current_user.diaries.build(diary_params)

    if @diary.save
      session[:diary_created] = true
      redirect_to complete_diary_path(@diary)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diaries/1
  def update
    if @diary.update(diary_params)
      redirect_to @diary, success: t('flash_message.updated', item: Diary.model_name.human), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy!
    redirect_to diaries_url, success: t('flash_message.destroyed', item: Diary.model_name.human), status: :see_other
  end

  # GET /diaries/1/complete
  def complete
    unless session.delete(:diary_created)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /diaries/my_diaries
  def my_diaries
    @q = current_user.diaries.ransack(params[:q])
    @diaries = @q.result(distinct: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = current_user.diaries.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diary_params
      params.require(:diary).permit(:content1, :content2, :content3, :allow_publication, :allow_comments)
    end
end
