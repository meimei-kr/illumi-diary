class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    retrieve_avatar_image_from_cache
    retrieve_character_image_from_cache

    if @user.save
      auto_login(@user)
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
end
