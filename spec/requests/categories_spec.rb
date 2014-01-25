require 'spec_helper'

describe "Categories" do
  before do
    create(:category, name: 'Visual Systems')
    create(:category, name: 'Dental Units')
    create(:category, name: 'Components')
  end

  describe "GET /dentail-units" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get dentals_path
      response.status.should be(200)
    end
  end
  describe "GET /visual-systems" do
    it "works! (now write some real specs)" do
      get visuals_path
      response.status.should be(200)
    end
  end
  describe "GET /components" do
    it "works! (now write some real specs)" do
      get components_path
      response.status.should be(200)
    end
  end
end
