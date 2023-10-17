class UserDecorator < ApplicationDecorator
  delegate_all

  def medal_to_give
    if object.continuous_writing_days == Medal::BRONZE
      "#{Medal::BRONZE}日間日記を続けられたので、銅メダルを授与します！"
    elsif object.continuous_writing_days == Medal::SILVER
      "#{Medal::SILVER}日間日記を続けられたので、銀メダルを授与します！"
    elsif object.continuous_writing_days == Medal::GOLD
      "#{Medal::GOLD}日間日記を続けられたので、金メダルを授与します！"
    else
      nil
    end
  end

  def medal_color
    case
    when self.gold?
      "#f4d35e"
    when self.silver?
      "#6c6c6c"
    when self.bronze?
      "#ac6b25"
    else
      nil
    end
  end
end
