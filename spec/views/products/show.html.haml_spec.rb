require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Slug/)
    rendered.should match(//)
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Slogan/)
  end
end
