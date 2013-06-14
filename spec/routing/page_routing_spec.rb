require "spec_helper"

describe PageController do
  describe "routing" do

    describe "pages" do
      it "Home routes to #page" do
        get("/").should route_to("page#page", page: 'home')
      end

      it "Contacts routes to #page" do
        get("/contacts").should route_to("page#contacts", page: 'contacts')
      end

      it "Promotions routes to #page" do
        get("/promotions").should route_to("page#page", page: 'promotions')
      end
    end
  end
end
