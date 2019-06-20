FactoryBot.define do
  factory :car do
    user

    name { "Car-#{FFaker::Lorem.word}" }
    color { FFaker::Color.name }
    code { FFaker::Code.ean }
    description { FFaker::Lorem.sentence }
  end
end
