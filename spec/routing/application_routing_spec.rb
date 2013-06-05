require "spec_helper"

describe ApplicationController do
  describe "routing" do

    describe "categories" do
      it "Dental Units routes to #category" do
        get("/dental-units").should route_to("application#category")
      end

      it "Visual Systems routes to #category" do
        get("/visual-systems").should route_to("application#category")
      end

      it "Components routes to #category" do
        get("/components").should route_to("application#category")
      end
    end

    describe "inner-categories" do
      it "Tomografy routes to #category" do
        get("/visual-systems/tomografy").should route_to("application#inner_category")
      end

      it "Avtoklavy routes to #category" do
        get("/components/avtoklavy").should route_to("application#inner_category")
      end
    end

    describe "brands" do
      it "Dental Units routes to #category" do
        get("/dental-units/fedesa").should route_to("application#brand")
      end

      it "Visual Systems routes to #category" do
        get("/visual-systems/tomografy/fedesa/testovyy-tomograf").
            should route_to("application#product")
      end

      it "Components routes to #category" do
        get("/components/avtoklavy/wandong/m11").
            should route_to("application#product")
      end
    end

  end
end
