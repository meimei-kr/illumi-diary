# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit edit_password update update_password]

  def show; end

  def edit; end

  def edit_password; end

  def update
    @user.updating_password = false # パスワード更新フラグをfalseにする

    @user.assign_attributes(profile_params)
    retrieve_avatar_image_from_cache
    retrieve_character_image_from_cache

    if @user.save
      redirect_to profile_url, success: t('flash_message.updated', item: 'ユーザー情報')
    else
      flash.now[:error] = t('flash_message.not_updated', item: 'ユーザー情報')
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    @user.updating_password = true # パスワード更新フラグをtrueにする

    # 現在のパスワードが正しくない場合
    unless @user.valid_password?(password_params[:current_password])
      flash.now[:error] = t('flash_message.not_valid')
      return render :edit_password, status: :unprocessable_entity
    end

    # 新しいパスワードと確認用パスワードが一致しない場合
    unless password_params[:password] == password_params[:password_confirmation]
      flash.now[:error] = t('flash_message.not_corresponded')
      return render :edit_password, status: :unprocessable_entity
    end

    if @user.update(password: password_params[:password], password_confirmation: password_params[:password_confirmation])
      redirect_to profile_url, success: t('flash_message.updated', item: User.human_attribute_name(:password))
    else
      flash.now[:error] = t('flash_message.not_updated', item: User.human_attribute_name(:password))
      render :edit_password, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :email, :avatar_image, :character_image, :avatar_image_cache, :character_image_cache)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

  def set_profile
    @user = User.find(current_user.id)
  end

  # キャッシュからアバター画像を取得する
  def retrieve_avatar_image_from_cache
    if !@user.will_save_change_to_avatar_image? && @user.avatar_image_cache.present?
      @user.avatar_image = nil # キャッシュから画像を取得するために一度nilにする
      @user.avatar_image.retrieve_from_cache!(@user.avatar_image_cache)
    end
    @user.avatar_image_cache = @user.avatar_image.cache_name
  end

  # キャッシュからキャラクター画像を取得する
  def retrieve_character_image_from_cache
    if !@user.will_save_change_to_character_image? && @user.character_image_cache.present?
      @user.character_image = nil  # キャッシュから画像を取得するために一度nilにする
      @user.character_image.retrieve_from_cache!(@user.character_image_cache)
    end
    @user.character_image_cache = @user.character_image.cache_name
  end
end
