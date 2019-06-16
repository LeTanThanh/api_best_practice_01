class Car < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true
end
