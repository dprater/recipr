require 'rails_helper'

RSpec.describe "recipes/new", type: :view do
  before(:each) do
    assign(:categories, [Category.new(name: 'cat1')])
    assign(:recipe, Recipe.new(
      :name => "MyString",
      :description => "MyString",
      :instructions => "MyString"
    ))
  end

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do

      assert_select "input#recipe_name[name=?]", "recipe[name]"

      assert_select "textarea#recipe_description[name=?]", "recipe[description]"

      assert_select "textarea#recipe_instructions[name=?]", "recipe[instructions]"
    end
  end
end
