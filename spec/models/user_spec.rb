require "rails_helper"

RSpec.describe User, type: :model do
  describe "associations" do
    context "cars" do
      it do
        is_expected.to have_many(:cars)
      end
    end

    context "tokens" do
      it do
        is_expected.to have_many(:tokens)
      end
    end
  end

  describe "validations" do
    context "email" do
      context "presence" do
        it do
          is_expected.to validate_presence_of(:email)
        end
      end

      context "format" do
        it do
          is_expected.to allow_value("valid.email@sun-asterisk.com").for(:email)
          is_expected.not_to allow_value("invalid.email").for(:email)
        end
      end
    end

    context "password" do
      context "presence" do
        it do
          is_expected.to validate_presence_of(:password)
        end
      end

      context "length" do
        it do
          is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(128)
        end
      end

      context "confirmation" do
        it do
          is_expected.to validate_confirmation_of(:password)
        end
      end
    end
  end
end
