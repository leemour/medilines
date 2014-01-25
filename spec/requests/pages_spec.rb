require 'spec_helper'

describe "Pages" do
  describe "GET /" do
    it "works!" do
      page = create(:page, :published, title: 'Home')
      page.should be_valid
      get root_path
      response.should be_success
    end
  end

  describe "GET /contacts" do
    it "works!" do
      page = create(:page, :published, title: 'Contacts')
      page.should be_valid
      get contacts_path
      response.should be_success
    end
  end

  describe "GET /promotions" do
    it "works!" do
      page = create(:page, :published, title: 'Promotions')
      page.should be_valid
      get promotions_path
      response.should be_success
    end
  end

  describe "GET /mail-sent" do
    it "works!" do
      page = create(:page, :published, title: 'Mail Sent')
      page.should be_valid
      get mail_sent_path
      response.should be_success
    end
  end

  # describe "POST /contacts" do
  #   it "works! (now write some real specs)" do
  #     # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
  #     post contacts_path
  #     response.should be_success
  #   end
  # end
end