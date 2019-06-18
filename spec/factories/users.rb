FactoryBot.define do
  factory :user do
    email { "some.one@sun-asterisk.com" }
    password { "Aa@123456789" }
    password_confirmation { "Aa@123456789" }
  end
end
