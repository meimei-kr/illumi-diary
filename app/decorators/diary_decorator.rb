class DiaryDecorator < ApplicationDecorator
  delegate_all

  def random_message
    messages = [
      "素敵な日記をありがとう！明日も素敵なことがたくさん起こりますように！",
      "日記を書くことで、今日1日を振り返る素敵な時間を持てたね！",
      "今日も一日お疲れさま。明日のためにゆっくり休んでね。",
      "今日1日振り返ったことを、明日へのエネルギーに変えちゃおう！",
      "今日は嬉しいことがたくさんあったね。明日ももっと幸せなことが起こりますように！",
      "幸せな気持ちになれる日記をありがとう！これからも毎日を大切に過ごしてね。",
      "ポジティブなことを日記に書くと、感謝の気持ちでいっぱいになれるね！",
      "日記を書くことで、自分の成長を実感できるね。これからも続けよう！",
      "過去は変えられないけれど、未来は変えられる。日記を書くことで、自分の未来をもっと輝かせられるよ。",
      "日記は心の旅。自分の心を見つめ、未来への道を見つけよう。"
    ]
    messages.sample
  end
end