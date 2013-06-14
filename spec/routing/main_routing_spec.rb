require "spec_helper"

describe MainController do
  describe "routing" do

    describe "categories" do
      it "Dental Units routes to #category" do
        get("/dental-units").should route_to("main#category",
                                             category: 'dental-units')
      end

      it "Visual Systems routes to #category" do
        get("/visual-systems").should route_to("main#category",
                                               category: 'visual-systems')
      end

      it "Components routes to #category" do
        get("/components").should route_to("main#category",
                                           category: 'components')
      end
    end


    describe "inner-categories" do
      it "Tomografy routes to #category" do
        get("/visual-systems/tomografy").should route_to("main#subcategory",
           category: 'visual-systems', subcategory: 'tomografy')
      end

      it "Avtoklavy routes to #category" do
        get("/components/avtoklavy").should route_to("main#subcategory",
           category: 'components', subcategory: 'avtoklavy')
      end
    end


    describe "brands" do
      it "Dental Units routes to #category" do
        get("/dental-units/fedesa").should route_to("main#category_brand",
            category: 'dental-units', brand: 'fedesa')
      end
      it "Dental Units routes to #category" do
        get("/visual-systems/tomografy/fedesa").
            should route_to("main#subcategory_brand", category: 'visual-systems',
            subcategory: 'tomografy', brand: 'fedesa')
      end
    end


    describe 'products' do
      it "Visual Systems routes to #category" do
        get("/visual-systems/tomografy/fedesa/testovyy-tomograf").
            should route_to("main#product", category: 'visual-systems',
            subcategory: 'tomografy', brand: 'fedesa', product: 'testovyy-tomograf')
      end

      it "Components routes to #category" do
        get("/components/avtoklavy/wandong/m11").
            should route_to("main#product", category: 'components',
            subcategory: 'avtoklavy', brand: 'wandong', product: 'm11')
      end
    end

  end
end
