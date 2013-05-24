class DropTableCategoryBrand < ActiveRecord::Migration
  def change
    drop_table :category_brand
  end
end
