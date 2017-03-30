require 'rails_helper'

RSpec.describe "recipes/edit", type: :view do
  before(:each) do
    @categories = [Category.create!(name: 'cat1', description: 'desc 1')]
    @recipe = assign(:recipe, Recipe.create!(
      :name => "MyString",
      :description => "MyString",
      :instructions => "MyString",
      :categories => @categories
    ))
  end

  it "renders the edit recipe form" do
    render

    assert_select "form[action=?][method=?]", recipe_path(@recipe), "post" do

      assert_select "input#recipe_name[name=?]", "recipe[name]"

      assert_select "textarea#recipe_description[name=?]", "recipe[description]"

      assert_select "textarea#recipe_instructions[name=?]", "recipe[instructions]"
    end
  end
end
