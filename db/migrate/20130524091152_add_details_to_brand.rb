class AddDetailsToBrand < ActiveRecord::Migration
  def up
    change_table :brands do |t|
      t.text :details
    end
  end

  def down
    change_table :brands do |t|
      t.remove :details
    end
  end
end
