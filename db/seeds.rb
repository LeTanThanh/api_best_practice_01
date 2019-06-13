10.times do
  Car.create name: "Car-#{FFaker::Lorem.word}",
    color: FFaker::Color.name,
    code: FFaker::Code.ean,
    description: FFaker::Lorem.sentence
end
