class CreateCategoryBrandTable < ActiveRecord::Migration
  def up
    create_table :category_brand, :id => false do |t|
      t.references :category, :null => false
      t.references :brand, :null => false
    end

    add_index(:category_brand, [:category_id, :brand_id])
  end

  def down
  end
end
