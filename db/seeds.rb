50.times do
  user = User.new
  user.name = Faker::Name.name
  user.email = Faker::Internet.email
  user.password = "password"
  user.password_confirmation = "password"
  user.save!
end

