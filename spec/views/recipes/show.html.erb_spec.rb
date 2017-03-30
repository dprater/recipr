require 'rails_helper'

RSpec.describe "recipes/show", type: :view do
  before(:each) do
    @categories = [Category.create!(name: 'cat1', description: 'desc1')]
    @recipe = assign(:recipe, Recipe.create!(
      :name => "Name",
      :description => "Description",
      :instructions => "Instructions",
      :categories => @categories
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Instructions/)
  end
end
