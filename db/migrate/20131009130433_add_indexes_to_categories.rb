class AddIndexesToCategories < ActiveRecord::Migration
  def change
    add_index :categories, :slug
    add_index :categories, :parent_id
  end
end
