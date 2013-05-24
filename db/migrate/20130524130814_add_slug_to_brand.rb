class AddSlugToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :slug, :string
    add_index :brands, :slug
  end
end
