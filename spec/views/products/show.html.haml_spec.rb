require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :slug => "Slug",
      :title => "Title",
      :brand => "Brand",
      :type => "Type",
      :price => 1,
      :country => "Country",
      :options => "",
      :features => "",
      :description => "MyText",
      :excerpt => "Excerpt",
      :slogan => "Slogan"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Slug/)
    rendered.should match(/Title/)
    rendered.should match(/Brand/)
    rendered.should match(/Type/)
    rendered.should match(/1/)
    rendered.should match(/Country/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(/Excerpt/)
    rendered.should match(/Slogan/)
  end
end
