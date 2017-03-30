require 'rails_helper'

RSpec.describe "recipes/index", type: :view do
  before(:each) do
    @categories = [Category.create!(name: 'cat1', description: 'desc 1')]
    assign(:recipes, [
      Recipe.create!(
        :name => "Name",
        :description => "Description",
        :instructions => "Instructions",
        :categories => @categories
      ),
      Recipe.create!(
        :name => "Name",
        :description => "Description",
        :instructions => "Instructions",
        :categories => @categories
      )
    ])
  end

  it "renders a list of recipes" do
    render
    assert_select "h2", :text => "Name".to_s, :count => 2
    assert_select "p", :text => "Description".to_s, :count => 2
  end
end
