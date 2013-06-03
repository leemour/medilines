class ChangeDescriptionTypeInProduct < ActiveRecord::Migration
  def up
    change_column :products, :description2, :text, :limit => nil
  end

  def down
    change_column :products, :description2, :string
  end
end
