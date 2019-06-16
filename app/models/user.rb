class User < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :tokens, dependent: :destroy

  validates :password_confirmation, presence: true, if: :password

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :validatable
end
