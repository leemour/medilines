require 'spec_helper'

describe Page do
  it "has a valid factory" do
    create(:page).should be_valid
  end

  it "is invalid without a title" do
    build(:page, title: nil).should_not be_valid
  end

  it "finds record" do
    page = create(:page, title: 'heyo')
    Page.unscoped.where(title: 'heyo').last.should == page
  end

  it "finds record with same attributes" do
    page = create(:page, title: 'mayo')
    Page.unscoped.where(title: 'mayo').last
      .should have_same_attributes_as(page)
  end
end
