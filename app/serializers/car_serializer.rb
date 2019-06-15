class CarSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :code, :description
end
