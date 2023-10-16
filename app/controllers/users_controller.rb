class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.new
    @guest_user = User.find_by(id: current_user&.id)
  end

  def create
    @user = User.new(user_params)
    @user.is_member = true

    @guest_user = nil

    # ゲストユーザーからの新規登録の場合
    if current_user.present?
      @guest_user = User.find_by(id: current_user.id)
      # ゲストユーザーの情報を新しいアカウントにコピー
      @user.avatar_image = @guest_user.avatar_image if @guest_user.avatar_image.present?
      @user.character_image = @guest_user.character_image if @guest_user.character_image.present?
    end

    retrieve_avatar_image_from_cache
    retrieve_character_image_from_cache

    if @user.save
      if @guest_user.present?
        # ゲストユーザーの日記、コメント、拍手を新しいアカウントに紐付ける
        Diary.where(user_id: @guest_user.id).update_all(user_id: @user.id)
        Comment.where(user_id: @guest_user.id).update_all(user_id: @user.id)
        Clap.where(user_id: @guest_user.id).update_all(user_id: @user.id)
        # ゲストユーザーの削除
        @guest_user.destroy!
      end

      auto_login(@user)

      # indexビューリクエスト方法識別用パラメータ
      session[:origin] = params[:origin]

      redirect_to diaries_path, success: t("flash_message.signup")
    else
      flash.now[:error] = t("flash_message.signup_failed")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                :avatar_image, :character_image,
                                :avatar_image_cache, :character_image_cache)
  end

  # キャッシュからアバター画像を取得する
  def retrieve_avatar_image_from_cache
    if @user.avatar_image.blank? && @user.avatar_image_cache.present?
      @user.avatar_image.retrieve_from_cache!(@user.avatar_image_cache)
    end
    @user.avatar_image_cache = @user.avatar_image.cache_name
  end

  # キャッシュからキャラクター画像を取得する
  def retrieve_character_image_from_cache
    if @user.character_image.blank? && @user.character_image_cache.present?
      @user.character_image.retrieve_from_cache!(@user.character_image_cache)
    end
    @user.character_image_cache = @user.character_image.cache_name
  end

  def redirect_if_logged_in
    if logged_in? && current_user&.is_member?
      # indexビューリクエスト方法識別用パラメータ
      session[:origin] = 'authentication'

      redirect_to diaries_path, success: t('flash_message.logged_in')
    end
  end
end
