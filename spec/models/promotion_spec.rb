require 'spec_helper'

describe Promotion do
  it "has a valid factory" do
    create(:promotion).should be_valid
  end
end
