10.times do |n|
  name  = Faker::Name.name
  Actor.create!(name:  name,
    picture: "a#{10+n}")
end
