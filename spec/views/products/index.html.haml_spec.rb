require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :slug => "Slug",
        :brand => nil,
        :name => "Name",
        :type => "Type",
        :price => 1,
        :options => "MyText",
        :features => "MyText",
        :design => "MyText",
        :description => "MyText",
        :slogan => "Slogan"
      ),
      stub_model(Product,
        :slug => "Slug",
        :brand => nil,
        :name => "Name",
        :type => "Type",
        :price => 1,
        :options => "MyText",
        :features => "MyText",
        :design => "MyText",
        :description => "MyText",
        :slogan => "Slogan"
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Slogan".to_s, :count => 2
  end
end
