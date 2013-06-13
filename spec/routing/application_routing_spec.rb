require "spec_helper"

describe ApplicationController do
  describe "routing" do

    describe "pages" do
      it "Home routes to #page" do
        get("/").should route_to("application#page", page: 'home')
      end

      it "Contacts routes to #page" do
        get("/contacts").should route_to("application#page", page: 'contacts')
      end

      it "Promotions routes to #page" do
        get("/promotions").should route_to("application#page", page: 'promotions')
      end
    end


    describe "categories" do
      it "Dental Units routes to #category" do
        get("/dental-units").should route_to("application#category",
                                             category: 'dental-units')
      end

      it "Visual Systems routes to #category" do
        get("/visual-systems").should route_to("application#category",
                                               category: 'visual-systems')
      end

      it "Components routes to #category" do
        get("/components").should route_to("application#category",
                                           category: 'components')
      end
    end


    describe "inner-categories" do
      it "Tomografy routes to #category" do
        get("/visual-systems/tomografy").should route_to("application#subcategory",
           category: 'visual-systems', subcategory: 'tomografy')
      end

      it "Avtoklavy routes to #category" do
        get("/components/avtoklavy").should route_to("application#subcategory",
           category: 'components', subcategory: 'avtoklavy')
      end
    end


    describe "brands" do
      it "Dental Units routes to #category" do
        get("/dental-units/fedesa").should route_to("application#brand",
            category: 'dental-units', brand: 'fedesa')
      end
    end


    describe 'products' do
      it "Visual Systems routes to #category" do
        get("/visual-systems/tomografy/fedesa/testovyy-tomograf").
            should route_to("application#product", category: 'visual-systems',
            subcategory: 'tomografy', brand: 'fedesa', product: 'testovyy-tomograf')
      end

      it "Components routes to #category" do
        get("/components/avtoklavy/wandong/m11").
            should route_to("application#product", category: 'components',
            subcategory: 'avtoklavy', brand: 'wandong', product: 'm11')
      end
    end

  end
end
