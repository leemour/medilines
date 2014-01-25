require 'spec_helper'

describe Product do
  it "orders by ascending name" do
    product1 = create(:product, name: 'one')
    product2 = create(:product, name: 'two')
    Product.unscoped.order("name ASC").should == [product1, product2]
  end

  it "has a valid factory" do
    create(:product).should be_valid
  end

  it "is invalid without a name" do
    build(:product, name: nil).should_not be_valid
  end

  it "finds record" do
    product = create(:product, name: 'heyo')
    Product.unscoped.where(:name => 'heyo').last.should == product
  end

  it "finds record with same attributes" do
    product = create(:product, name: 'mayo')
    Product.unscoped.where(name: 'mayo').last
      .should have_same_attributes_as(product)
  end
end
