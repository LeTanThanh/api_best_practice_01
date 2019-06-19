FactoryBot.define do
  factory :token do
    user

    token { "0123456789" }
  end
end
