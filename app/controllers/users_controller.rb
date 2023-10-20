# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.find_by(id: current_user&.id) || User.new
  end

  def create
    @user = User.new(user_params)
    @user.is_member = true

    retrieve_avatar_image_from_cache
    retrieve_character_image_from_cache

    if @user.save
      auto_login(@user)
      redirect_to diaries_url, success: t('flash_message.signup')
    else
      flash.now[:error] = t('flash_message.signup_failed')
      render :new, status: :unprocessable_entity
    end
  end

  # ゲストユーザーからの新規登録の場合
  def update
    @user = User.new(user_params)
    @user.is_member = true

    copy_guest_info

    if @user.save
      update_guest_related_info
      @guest_user.destroy!

      auto_login(@user)
      redirect_to diaries_url, success: t('flash_message.signup')
    else
      flash.now[:error] = t('flash_message.signup_failed')
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
    @user.avatar_image.retrieve_from_cache!(@user.avatar_image_cache) if @user.avatar_image.blank? && @user.avatar_image_cache.present?
    @user.avatar_image_cache = @user.avatar_image.cache_name
  end

  # キャッシュからキャラクター画像を取得する
  def retrieve_character_image_from_cache
    @user.character_image.retrieve_from_cache!(@user.character_image_cache) if @user.character_image.blank? && @user.character_image_cache.present?
    @user.character_image_cache = @user.character_image.cache_name
  end

  # ログイン済みであれば、日記一覧ページにリダイレクトする
  def redirect_if_logged_in
    return unless logged_in? && current_user&.is_member?

    redirect_to diaries_url, success: t('flash_message.logged_in')
  end

  # ゲストユーザーの情報を新しいアカウントにコピーする
  def copy_guest_info
    @guest_user = User.find_by(id: current_user.id)
    @user.avatar_image = @guest_user.avatar_image if @guest_user.avatar_image.present?
    @user.character_image = @guest_user.character_image if @guest_user.character_image.present?
    retrieve_avatar_image_from_cache
    retrieve_character_image_from_cache
  end

  # ゲストユーザーに紐づく情報を更新する
  def update_guest_related_info
    # ゲストユーザーの日記、コメント、拍手を新しいアカウントに紐付ける
    Diary.where(user_id: @guest_user.id).find_each(batch_size: 100) do |diary|
      diary.update(user_id: @user.id)
    end
    Comment.where(user_id: @guest_user.id).find_each(batch_size: 100) do |comment|
      comment.update(user_id: @user.id)
    end
    Clap.where(user_id: @guest_user.id).find_each(batch_size: 100) do |clap|
      clap.update(user_id: @user.id)
    end
  end
end
