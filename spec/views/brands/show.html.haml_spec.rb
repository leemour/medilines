require 'spec_helper'

describe "brands/show" do
  before(:each) do
    @brand = assign(:brand, stub_model(Brand,
      :name => "Name",
      :country => "Country",
      :slogan => "Slogan",
      :description => "MyText",
      :logo => "Logo",
      :image => "Image",
      :flag => "Flag"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Country/)
    rendered.should match(/Slogan/)
    rendered.should match(/MyText/)
    rendered.should match(/Logo/)
    rendered.should match(/Image/)
    rendered.should match(/Flag/)
  end
end
