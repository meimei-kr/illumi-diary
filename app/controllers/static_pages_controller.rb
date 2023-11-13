# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy_policy]

  def top; end

  def terms; end

  def privacy_policy; end
end
