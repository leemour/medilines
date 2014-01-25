require 'spec_helper'
require 'rake_helper'

describe "image_versions:recreate" do
  include_context "rake"

  its(:prerequisites) { should include("environment") }


end

describe "table_column:update_all" do
  include_context "rake"

  before do
    @uploader_class = Class.new(CarrierWave::Uploader::Base)
    @uploader = @uploader_class.new
  end

  its(:prerequisites) { should include("environment") }


end
