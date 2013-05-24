class RenameCategoriesBrands < ActiveRecord::Migration
  def change
    rename_table :categories_brands, :brands_categories
  end
end
