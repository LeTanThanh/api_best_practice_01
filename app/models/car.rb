class Car < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :color, presence: true
  validates :code, presence: true, uniqueness: true
  validates :description, presence: true

  belongs_to :user
end
