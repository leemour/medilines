# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130523182306) do

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "country"
    t.string   "slogan"
    t.text     "description"
    t.string   "logo"
    t.string   "image"
    t.string   "flag"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "slug"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "category_brand", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "brand_id",    :null => false
  end

  add_index "category_brand", ["category_id", "brand_id"], :name => "index_category_brand_on_category_id_and_brand_id"

  create_table "products", :force => true do |t|
    t.string   "slug"
    t.integer  "brand_id"
    t.string   "name"
    t.string   "type"
    t.integer  "price"
    t.text     "options"
    t.text     "features"
    t.text     "design"
    t.text     "description"
    t.string   "slogan"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "products", ["brand_id"], :name => "index_products_on_brand_id"

end
