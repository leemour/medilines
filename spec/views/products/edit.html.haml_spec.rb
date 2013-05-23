require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :slug => "MyString",
      :title => "MyString",
      :brand => "MyString",
      :type => "",
      :price => 1,
      :country => "MyString",
      :options => "",
      :features => "",
      :description => "MyText",
      :excerpt => "MyString",
      :slogan => "MyString"
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", product_path(@product), "post" do
      assert_select "input#product_slug[name=?]", "product[slug]"
      assert_select "input#product_title[name=?]", "product[title]"
      assert_select "input#product_brand[name=?]", "product[brand]"
      assert_select "input#product_type[name=?]", "product[type]"
      assert_select "input#product_price[name=?]", "product[price]"
      assert_select "input#product_country[name=?]", "product[country]"
      assert_select "input#product_options[name=?]", "product[options]"
      assert_select "input#product_features[name=?]", "product[features]"
      assert_select "textarea#product_description[name=?]", "product[description]"
      assert_select "input#product_excerpt[name=?]", "product[excerpt]"
      assert_select "input#product_slogan[name=?]", "product[slogan]"
    end
  end
end
