json.extract! ingredient, :id, :name, :quantity, :unit_of_measurement, :description, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
