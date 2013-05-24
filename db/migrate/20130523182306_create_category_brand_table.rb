class CreateCategoryBrandTable < ActiveRecord::Migration
  def up
    create_table :categories_brands, :id => false do |t|
      t.references :category, :null => false
      t.references :brand, :null => false
    end

    add_index(:categories_brands, [:category_id, :brand_id])
  end

  def down
    drop_table :categories_brands
  end
end
