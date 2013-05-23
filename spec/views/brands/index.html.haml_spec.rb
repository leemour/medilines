require 'spec_helper'

describe "brands/index" do
  before(:each) do
    assign(:brands, [
      stub_model(Brand,
        :name => "Name",
        :country => "Country",
        :slogan => "Slogan",
        :description => "MyText",
        :logo => "Logo",
        :image => "Image",
        :flag => "Flag"
      ),
      stub_model(Brand,
        :name => "Name",
        :country => "Country",
        :slogan => "Slogan",
        :description => "MyText",
        :logo => "Logo",
        :image => "Image",
        :flag => "Flag"
      )
    ])
  end

  it "renders a list of brands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Slogan".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Logo".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "Flag".to_s, :count => 2
  end
end
