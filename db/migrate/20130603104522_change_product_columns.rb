class ChangeProductColumns < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.remove :type, :options, :design
      t.string :description2
      t.rename :description, :description1
    end
  end

  def down
    change_table :products do |t|
      t.remove :description2
      t.text :options
      t.text :design
      t.rename :description1, :description
    end
  end
end
