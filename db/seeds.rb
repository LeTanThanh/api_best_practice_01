5.times do
  name = FFaker::Name.name
  email = name.split(" ").map(&:downcase).join(".") + "@sun-asterisk.com"

  user = User.create email: email, password: "Aa@123456789",
    password_confirmation: "Aa@123456789"

  5.times do
    user.cars.create name: "Car-#{FFaker::Lorem.word}",
      color: FFaker::Color.name,
      code: FFaker::Code.ean,
      description: FFaker::Lorem.sentence
  end
end
