require 'spec_helper'

describe "brands/new" do
  before(:each) do
    assign(:brand, stub_model(Brand,
      :name => "MyString",
      :country => "MyString",
      :slogan => "MyString",
      :description => "MyText",
      :logo => "MyString",
      :image => "MyString",
      :flag => "MyString"
    ).as_new_record)
  end

  it "renders new brand form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", brands_path, "post" do
      assert_select "input#brand_name[name=?]", "brand[name]"
      assert_select "input#brand_country[name=?]", "brand[country]"
      assert_select "input#brand_slogan[name=?]", "brand[slogan]"
      assert_select "textarea#brand_description[name=?]", "brand[description]"
      assert_select "input#brand_logo[name=?]", "brand[logo]"
      assert_select "input#brand_image[name=?]", "brand[image]"
      assert_select "input#brand_flag[name=?]", "brand[flag]"
    end
  end
end
