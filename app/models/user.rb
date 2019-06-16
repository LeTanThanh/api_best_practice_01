class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable, :rememberable
  devise :database_authenticatable, :registerable, :validatable

  validates :password_confirmation, presence: true, if: :password

  has_many :cars, dependent: :destroy
end
