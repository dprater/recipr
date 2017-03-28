require 'rails_helper'

RSpec.describe "ingredients/show", type: :view do
  before(:each) do
    @ingredient = assign(:ingredient, Ingredient.create!(
      :name => "Name",
      :quantity => 2.5,
      :unit_of_measurement => "Unit Of Measurement",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/Unit Of Measurement/)
    expect(rendered).to match(/Description/)
  end
end
