# frozen_string_literal: true

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]
  before_action :redirect_if_logged_in, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to diaries_path, success: t('flash_message.login')
    else
      flash.now[:error] = t('flash_message.login_failed')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to login_path, success: t('flash_message.logout'), status: :see_other
  end

  def guest_login
    guest_email = "guest_#{SecureRandom.alphanumeric(10)}@example.com"
    password = SecureRandom.urlsafe_base64
    loop do
      @user = User.create(
        name: 'ゲスト',
        email: guest_email,
        password:,
        password_confirmation: password
      )
      break if @user.persisted?
    end

    auto_login(@user)
    redirect_to diaries_path, success: t('flash_message.guest_login')
  end

  private

  def redirect_if_logged_in
    return unless logged_in? && current_user&.is_member?

    redirect_to diaries_path, success: t('flash_message.logged_in')
  end
end
