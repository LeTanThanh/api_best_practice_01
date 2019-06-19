require "rails_helper"

RSpec.describe Car, type: :model do
  describe "associations" do
    describe "users" do
      it do
        is_expected.to belong_to(:user)
      end
    end
  end

  describe "validations" do
    describe "name" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:name)
        end
      end

      describe "uniqueness" do
        it do
          is_expected.to validate_uniqueness_of(:name)
        end
      end
    end

    describe "color" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:color)
        end
      end
    end

    describe "code" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:code)
        end
      end

      describe "uniqueness" do
        it do
          is_expected.to validate_uniqueness_of(:code)
        end
      end
    end

    describe "description" do
      describe "presence" do
        it do
          is_expected.to validate_presence_of(:description)
        end
      end
    end
  end
end
