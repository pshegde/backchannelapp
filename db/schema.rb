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

ActiveRecord::Schema.define(:version => 20120922210500) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comment_votes", :force => true do |t|
    t.integer  "User_id"
    t.integer  "Post_id"
    t.integer  "Comment_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "content"
    t.integer  "Post_id"
    t.integer  "User_id"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "num_votes",  :default => 0
  end

  create_table "posts", :force => true do |t|
    t.text     "title"
    t.text     "content"
    t.integer  "User_id"
    t.integer  "Category_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "num_votes",   :default => 0
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "password"
    t.string   "salt"
    t.boolean  "admin"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "User_id"
    t.integer  "Post_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
