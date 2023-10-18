# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all

  def medal_to_give
    case object.continuous_writing_days
    when Medal::BRONZE
      "#{Medal::BRONZE}日間日記を続けられたので、銅メダルを授与します！"
    when Medal::SILVER
      "#{Medal::SILVER}日間日記を続けられたので、銀メダルを授与します！"
    when Medal::GOLD
      "#{Medal::GOLD}日間日記を続けられたので、金メダルを授与します！"
    end
  end

  def medal_color
    if gold?
      '#f4d35e'
    elsif silver?
      '#6c6c6c'
    elsif bronze?
      '#ac6b25'
    end
  end
end
