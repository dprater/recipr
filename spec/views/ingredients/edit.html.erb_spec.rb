require 'rails_helper'

RSpec.describe "ingredients/edit", type: :view do
  before(:each) do
    @ingredient = assign(:ingredient, Ingredient.create!(
      :name => "MyString",
      :quantity => 1.5,
      :unit_of_measurement => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredient_path(@ingredient), "post" do

      assert_select "input#ingredient_name[name=?]", "ingredient[name]"

      assert_select "input#ingredient_quantity[name=?]", "ingredient[quantity]"

      assert_select "input#ingredient_unit_of_measurement[name=?]", "ingredient[unit_of_measurement]"

      assert_select "input#ingredient_description[name=?]", "ingredient[description]"
    end
  end
end
