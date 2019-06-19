require "rails_helper"

RSpec.describe Token, type: :model do
  describe "asociations" do
    describe "user" do
      it do
        is_expected.to belong_to(:user)
      end
    end
  end

  describe "validations" do
    describe "token" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:token)
        end
      end

      describe "uniqueness" do
        it do
          is_expected.to validate_uniqueness_of(:token)
        end
      end
    end
  end

  describe ".class_method" do
    describe ".generate_unique_token" do
      it "returns unique token" do
        token = Token.generate_unique_token

        expect(Token.find_by token: token).to eq(nil)
      end
    end
  end
end
