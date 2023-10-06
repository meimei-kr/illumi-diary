class UserDecorator < ApplicationDecorator
  delegate_all

  def medal_to_give
    if object.continuous_writing_days == 7
      "7日間日記を続けられたので、銅メダルを授与します！"
    elsif object.continuous_writing_days == 30
      "30日間日記を続けられたので、銀メダルを授与します！"
    elsif object.continuous_writing_days == 100
      "100日間日記を続けられたので、金メダルを授与します！"
    else
      nil
    end
  end

  def medal_color
    consecutive_days = object.continuous_writing_days
    case
    when consecutive_days >= 100
      "#f4d35e"
    when consecutive_days >= 30
      "#6c6c6c"
    when consecutive_days >= 7
      "#ac6b25"
    else
      nil
    end
  end
end
