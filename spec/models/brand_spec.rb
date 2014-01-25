require 'spec_helper'

describe Brand do
  it "has a valid factory" do
    create(:brand).should be_valid
  end
end
