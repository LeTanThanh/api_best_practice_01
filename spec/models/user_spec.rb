require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    describe "cars" do
      it do
        is_expected.to have_many(:cars)
      end
    end

    describe "tokens" do
      it do
        is_expected.to have_many(:tokens)
      end
    end
  end

  describe "validations" do
    describe "email" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:email)
        end
      end

      describe "format" do
        it do
          is_expected.to allow_value("valid.email@sun-asterisk.com").for(:email)
          is_expected.not_to allow_value("invalid.email").for(:email)
        end
      end
    end

    describe "password" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:password)
        end
      end

      describe "length" do
        it do
          is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(128)
        end
      end

      describe "confirmation" do
        it do
          is_expected.to validate_confirmation_of(:password)
        end
      end
    end
  end
end
