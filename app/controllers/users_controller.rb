class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.avatar_image.blank? && @user.avatar_image_cache.present?
      @user.avatar_image.retrieve_from_cache!(@user.avatar_image_cache)
    end
    @user.avatar_image_cache = @user.avatar_image.cache_name

    if @user.character_image.blank? && @user.character_image_cache.present?
      @user.character_image.retrieve_from_cache!(@user.character_image_cache)
    end
    @user.character_image_cache = @user.character_image.cache_name

    if @user.save
      auto_login(@user)
      redirect_to login_path, success: "登録が完了しました。"
    else
      flash.now[:error] = "登録に失敗しました。"
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
end
