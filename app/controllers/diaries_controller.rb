class DiariesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_diary, only: %i[ edit update destroy complete ]

  # GET /diaries
  def index
    page_limit = 10
    @current_page = params[:page].to_i
    all_public_diaries = Diary.includes(:user).where(allow_publication: true).order(created_at: :desc)
    @diaries = all_public_diaries.offset(page_limit * @current_page).limit(page_limit)
    @next_page = @current_page + 1 if all_public_diaries.count > (page_limit * @current_page + page_limit)
  end

  # GET /diaries/1
  def show
    @diary = Diary.find(params[:id])
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
      redirect_to @diary, success: t('flash_message.updated', item: Diary.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy!
    if request.referer&.include?('/my_diaries') # My日記ページから日記を削除したとき
      redirect_to my_diaries_diaries_url, success: t('flash_message.destroyed', item: Diary.model_name.human), status: :see_other
    elsif request.referer&.include?('/diaries/')  # 日記詳細ページから日記を削除したとき
      session[:origin] = params[:origin]
      redirect_to diaries_url, success: t('flash_message.destroyed', item: Diary.model_name.human), status: :see_other
    else  # みんなの日記ページから日記を削除したとき
      redirect_to diaries_url, success: t('flash_message.destroyed', item: Diary.model_name.human), status: :see_other
    end
  end

  # GET /diaries/1/complete
  def complete
    unless session.delete(:diary_created)
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  # GET /diaries/my_diaries
  def my_diaries
    page_limit = 10
    @current_page = params[:page].to_i
    @q = current_user.diaries.ransack(params[:q])
    all_my_diaries = @q.result(distinct: true).order(created_at: :desc)
    @diaries = all_my_diaries.offset(page_limit * @current_page).limit(page_limit)
    @next_page = @current_page + 1 if all_my_diaries.count > (page_limit * @current_page + page_limit)
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
