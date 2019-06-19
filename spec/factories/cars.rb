FactoryBot.define do
  factory :car do
    user

    name { "Car SunInc" }
    color { "Red" }
    code { "0123456789"}
    description { "Example car" }
  end
end
