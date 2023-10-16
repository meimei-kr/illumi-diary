consecutive_days_array = [6, 29, 99]

consecutive_days_array.each do |consecutive_days|
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    is_member: true
  )

  consecutive_days.times do |m|
    user.diaries.create!(
      content1: Faker::Lorem.sentences(number: 1),
      content2: Faker::Lorem.sentences(number: 1),
      content3: Faker::Lorem.sentences(number: 1),
      allow_publication: true,
      allow_comments: true,
      created_at: Time.zone.today - (m + 1).days
    )
  end
end