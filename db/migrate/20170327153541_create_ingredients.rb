class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :quantity
      t.string :unit_of_measurement
      t.string :description

      t.timestamps null: false
    end
  end
end
