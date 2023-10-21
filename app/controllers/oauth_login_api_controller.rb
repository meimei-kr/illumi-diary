class OauthLoginApiController < ApplicationController
  skip_before_action :require_login, only: [:oauth, :callback]

  def oauth
    #指定されたプロバイダの認証ページにユーザーをリダイレクトさせる
    login_at(oauth_params[:provider])
  end

  def callback
    provider = oauth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(provider))
      redirect_to diaries_url, success: t('flash_message.login')
    else
      # プロバイダから取得したユーザー情報を元にユーザーを作成し、ログイン
      begin
        @user = create_from(provider)
        @user.update!(is_member: true)
        reset_session
        auto_login(@user)
        redirect_to diaries_url, success: t('flash_message.signup')
      rescue StandardError
        redirect_to login_url, danger: t('flash_message.oauth_login_failed')
      end
    end
  end

  private

  def oauth_params
    params.permit(:code, :provider)
  end
end
