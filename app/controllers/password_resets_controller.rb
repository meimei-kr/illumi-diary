class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  # パスワード再設定用のメールを送信する
  def create
    if params[:email].blank?
      flash.now[:error] = t('flash_message.email_required')
      return render :new, status: :unprocessable_entity
    end
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!
    redirect_to login_path, success: t('flash_message.sent_instructions')
  end

  # パスワード再設定用フォームを開く
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?
  end

  # パスワード更新実行
  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(@token)
    return not_authenticated if @user.blank?

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password(params[:user][:password])
      redirect_to login_path, success: t('flash_message.updated', item: User.human_attribute_name(:password))
    else
      flash.now[:error] = t('.flash_message.not_updated', item: User.human_attribute_name(:password))
      render 'edit', status: :unprocessable_entity
    end
  end
end
