class ChangeIndexInBrandsCategories < ActiveRecord::Migration
  def up
    drop_table :brands_categories

    create_table :brands_categories, :id => false do |t|
      t.references :category, :null => false
      t.references :brand, :null => false
    end

    add_index(:brands_categories, [:category_id, :brand_id], :unique => true)
  end

  def down
    drop_table :brands_categories
  end
end
