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

ActiveRecord::Schema.define(:version => 20120122211359) do

  create_table "articles", :force => true do |t|
    t.string   "code",                                                       :null => false
    t.string   "name",                                                       :null => false
    t.decimal  "price",        :precision => 15, :scale => 3,                :null => false
    t.text     "description"
    t.integer  "brand_id"
    t.integer  "lock_version",                                :default => 0, :null => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "articles", ["brand_id"], :name => "index_articles_on_brand_id"
  add_index "articles", ["code"], :name => "index_articles_on_code"
  add_index "articles", ["name"], :name => "index_articles_on_name"

  create_table "articles_tags", :id => false, :force => true do |t|
    t.integer "article_id", :null => false
    t.integer "tag_id",     :null => false
  end

  add_index "articles_tags", ["article_id", "tag_id"], :name => "index_articles_tags_on_article_id_and_tag_id", :unique => true

  create_table "brands", :force => true do |t|
    t.string   "name",                        :null => false
    t.integer  "lock_version", :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "brands", ["name"], :name => "index_brands_on_name"

  create_table "tags", :force => true do |t|
    t.string   "name",                        :null => false
    t.integer  "lock_version", :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name"

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "lastname"
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
    t.integer  "roles_mask",             :default => 0,  :null => false
    t.integer  "lock_version",           :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["lastname"], :name => "index_users_on_lastname"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
