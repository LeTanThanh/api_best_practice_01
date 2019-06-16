class Token < ApplicationRecord
  belongs_to :user

  validates :token, presence: true, uniqueness: true

  class << self
    def generate_unique_token
      token = SecureRandom.hex
      return token unless Token.find_by(token: token)

      generate_unique_token
    end
  end
end
