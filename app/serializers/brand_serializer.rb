class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :active
end
