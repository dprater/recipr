require 'rails_helper'

RSpec.describe "ingredients/new", type: :view do
  before(:each) do
    assign(:ingredient, Ingredient.new(
      :name => "MyString",
      :quantity => 1.5,
      :unit_of_measurement => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredients_path, "post" do

      assert_select "input#ingredient_name[name=?]", "ingredient[name]"

      assert_select "input#ingredient_quantity[name=?]", "ingredient[quantity]"

      assert_select "input#ingredient_unit_of_measurement[name=?]", "ingredient[unit_of_measurement]"

      assert_select "input#ingredient_description[name=?]", "ingredient[description]"
    end
  end
end
