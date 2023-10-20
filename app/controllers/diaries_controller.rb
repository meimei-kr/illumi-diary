# frozen_string_literal: true

class DiariesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_diary, only: %i[edit update destroy complete]

  # GET /diaries
  def index
    page_limit = 10
    @current_page = params[:page].to_i

    all_public_diaries = Diary.includes(:user).where(allow_publication: true).order(created_at: :desc)
    @diaries = all_public_diaries.offset(page_limit * @current_page).limit(page_limit)

    @next_page = @current_page + 1 if all_public_diaries.count > ((page_limit * @current_page) + page_limit)
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
  def edit; end

  # POST /diaries
  def create
    @diary = current_user.diaries.build(diary_params)

    if @diary.save
      # 日記作成完了フラグをセッションに格納
      # 日記作成完了後のみ、完了画面を表示したいため、その判定用
      session[:diary_created] = true

      check_win_medal
      redirect_to complete_diary_url(@diary)
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
    else
      redirect_to diaries_url, success: t('flash_message.destroyed', item: Diary.model_name.human), status: :see_other
    end
  end

  # GET /diaries/1/complete
  def complete
    raise ActionController::RoutingError, 'Not Found' unless session.delete(:diary_created) #  日記作成完了フラグをセッションから削除
  end

  # GET /diaries/my_diaries
  def my_diaries
    page_limit = 10
    @current_page = params[:page].to_i

    set_q # 検索条件の設定
    all_my_diaries = @q.result(distinct: true).order(created_at: :desc)
    @diaries = all_my_diaries.offset(page_limit * @current_page).limit(page_limit)

    @next_page = @current_page + 1 if all_my_diaries.count > ((page_limit * @current_page) + page_limit)
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

  # メダル付与対象の日記記入継続日数か判定して、該当すればユーザーのランクを更新
  def check_win_medal
    case current_user.continuous_writing_days
    when Medal::BRONZE
      current_user.bronze!
    when Medal::SILVER
      current_user.silver!
    when Medal::GOLD
      current_user.gold!
    end
  end

  # 検索条件を指定しても、結果が表示される前にmy_diaries.turbo_stream.erbが
  # 呼び出されるために検索結果が表示されない不具合を解消するために、
  # 検索条件がある場合は、セッションに格納するようにする
  def set_q
    if session[:q].present?
      @q = current_user.diaries.ransack(session[:q])
      session.delete(:q)
    else
      session[:q] = params[:q]
      @q = current_user.diaries.ransack(params[:q])
    end
  end
end
