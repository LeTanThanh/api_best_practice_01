class CarSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :color, :code, :description
end
