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

ActiveRecord::Schema.define(:version => 20140109123746) do

  create_table "categories", :force => true do |t|
    t.integer  "entity_id"
    t.string   "name"
    t.boolean  "is_important"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "publications_count", :default => 0
  end

  create_table "entities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "avatar"
  end

  create_table "entities_users", :id => false, :force => true do |t|
    t.integer "entity_id"
    t.integer "user_id"
  end

  add_index "entities_users", ["entity_id", "user_id"], :name => "index_entities_users_on_entity_id_and_user_id"
  add_index "entities_users", ["user_id", "entity_id"], :name => "index_entities_users_on_user_id_and_entity_id"

  create_table "publications", :force => true do |t|
    t.integer  "category_id"
    t.integer  "shipping_id"
    t.string   "title"
    t.string   "short_content"
    t.string   "url"
    t.string   "source"
    t.string   "source_url"
    t.date     "published_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "receivers", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.integer  "entity_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "receivers_shippings", :id => false, :force => true do |t|
    t.integer "receiver_id"
    t.integer "shipping_id"
  end

  add_index "receivers_shippings", ["receiver_id", "shipping_id"], :name => "index_receivers_shippings_on_receiver_id_and_shipping_id"
  add_index "receivers_shippings", ["shipping_id", "receiver_id"], :name => "index_receivers_shippings_on_shipping_id_and_receiver_id"

  create_table "shippings", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "entity_id"
    t.integer  "total"
    t.integer  "processed"
    t.datetime "begin_at"
    t.datetime "end_at"
    t.string   "state"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "individuals"
  end

  create_table "source_covers", :force => true do |t|
    t.integer  "source_id"
    t.integer  "shipping_id"
    t.string   "image_cover"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "title_reg"
    t.string   "short_content_reg"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.datetime "published_at_reg"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.boolean  "is_admin"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
