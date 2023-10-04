class DiariesController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_diary, only: %i[ show edit update destroy complete ]

  # GET /diaries
  def index
    @diaries = Diary.includes(:user).where(allow_publication: true).order(created_at: :desc).page(params[:page]).per(10)
  end

  # GET /diaries/1
  def show
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
    @diary = Diary.new(diary_params)

    if @diary.save
      redirect_to @diary, notice: "Diary was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /diaries/1
  def update
    if @diary.update(diary_params)
      redirect_to @diary, notice: "Diary was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /diaries/1
  def destroy
    @diary.destroy
    redirect_to diaries_url, notice: "Diary was successfully destroyed.", status: :see_other
  end

  # GET /diaries/1/complete
  def complete
  end

  # GET /diaries/my_diaries
  def my_diaries
    @diaries = current_user.diaries.order(created_at: :desc)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diary_params
      params.require(:diary).permit(:content1, :content2, :content3, :user_id, :allow_publication, :allow_comments)
    end
end
