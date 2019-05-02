class UserSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :first_name,
    :last_name,
    :full_name, # `attributes` will work with custom methods
    :updated_at,
    :created_at
  )
end
