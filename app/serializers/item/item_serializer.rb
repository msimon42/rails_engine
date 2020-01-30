class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description
end
