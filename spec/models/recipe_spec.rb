require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:cat1) { Category.create!(name: 'cat1', description: 'desc 1') }
  let!(:cat2) { Category.create!(name: 'cat2', description: 'desc 2') }
  let!(:ing1) { Ingredient.create!(name: 'ing1', quantity: 1, unit_of_measurement: 'lb') }
  let!(:ing2) { Ingredient.create!(name: 'ing2', quantity: 2, unit_of_measurement: 'kg') }
  let!(:rec1) { Recipe.create!(name: 'rec1', description: 'desc 1', instructions: 'instr 1', categories: [cat1], ingredients: [ing1]) }
  let!(:rec2) { Recipe.create!(name: 'rec2', description: 'desc 2', instructions: 'instr 2', categories: [cat2], ingredients: [ing2]) }
  let!(:rec3) { Recipe.create!(name: 'rec3', description: 'desc 3', instructions: 'instr 3', categories: [cat2], ingredients: [ing1]) }
  let!(:rec4) { Recipe.create!(name: 'rec4', description: 'desc 4', instructions: 'instr 4', categories: [cat1], ingredients: [ing2]) }
  
  describe "#random_recipes" do  
    it 'returns 3 results when called with 3' do
      expect(Recipe.random_recipes(3).count).to eq(3)
    end

    it 'returns 2 results when called with 2' do
      expect(Recipe.random_recipes(2).count).to eq(2)
    end
  end

  describe '#has_category?' do
    it 'fails to save without a category' do
      expect{Recipe.create!(name: 'rec5', description: 'desc 5', instructions: 'instr 5', ingredients: [ing1])}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
