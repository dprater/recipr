require 'rails_helper'

RSpec.describe "categories/index", type: :view do
  before(:each) do
    assign(:categories, [
      Category.create!(
        :name => "Name",
        :description => "Description"
      ),
      Category.create!(
        :name => "Name",
        :description => "Description"
      )
    ])
  end

  it "renders a list of categories" do
    render
    assert_select "h3>a", :text => "Name".to_s, :count => 2
    #assert_select "div", :text => "Description".to_s, :count => 2
  end
end
