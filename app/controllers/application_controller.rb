class ApplicationController < ActionController::Base
  before_action :require_login

  rescue_from ActionController::RoutingError, with: :render_404

  private

  def not_authenticated
    redirect_to login_path
  end

  def render_404
    render file: Rails.public_path.join('404.html'), status: :not_found, content_type: 'text/html', layout: false
  end
end
