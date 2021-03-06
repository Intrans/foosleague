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

ActiveRecord::Schema.define(:version => 20121014184210) do

  create_table "games", :force => true do |t|
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.integer  "league_id"
    t.integer  "home_id"
    t.integer  "away_id"
    t.integer  "home_score", :default => 0, :null => false
    t.integer  "away_score", :default => 0, :null => false
  end

  create_table "league_memberships", :force => true do |t|
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "player_id",                         :null => false
    t.integer  "league_id",                         :null => false
    t.boolean  "admin",          :default => false, :null => false
    t.integer  "starting_skill", :default => 25,    :null => false
  end

  add_index "league_memberships", ["league_id", "player_id"], :name => "index_league_memberships_on_league_id_and_player_id", :unique => true
  add_index "league_memberships", ["league_id"], :name => "index_league_memberships_on_league_id"
  add_index "league_memberships", ["player_id"], :name => "index_league_memberships_on_player_id"

  create_table "leagues", :force => true do |t|
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.string   "name",       :limit => 128,                   :null => false
    t.boolean  "doubles",                   :default => true, :null => false
    t.string   "logo_uid"
    t.string   "logo_name"
    t.string   "slug",                                        :null => false
  end

  add_index "leagues", ["slug"], :name => "index_leagues_on_slug", :unique => true

  create_table "players", :force => true do |t|
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
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "twitter_name"
  end

  add_index "players", ["authentication_token"], :name => "index_players_on_authentication_token", :unique => true
  add_index "players", ["email"], :name => "index_players_on_email", :unique => true
  add_index "players", ["reset_password_token"], :name => "index_players_on_reset_password_token", :unique => true
  add_index "players", ["twitter_name"], :name => "index_players_on_twitter_name", :unique => true

  create_table "team_memberships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "player_id",  :null => false
    t.integer  "team_id",    :null => false
  end

  add_index "team_memberships", ["player_id"], :name => "index_team_memberships_on_player_id"
  add_index "team_memberships", ["team_id", "player_id"], :name => "index_team_memberships_on_team_id_and_player_id", :unique => true
  add_index "team_memberships", ["team_id"], :name => "index_team_memberships_on_team_id"

  create_table "teams", :force => true do |t|
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "league_id",                                :null => false
    t.string   "name",       :limit => 128
    t.string   "logo_uid"
    t.string   "logo_name"
    t.integer  "team_size",                 :default => 0, :null => false
    t.string   "slug",                                     :null => false
  end

  add_index "teams", ["league_id"], :name => "index_teams_on_league_id"
  add_index "teams", ["slug"], :name => "index_teams_on_slug", :unique => true

  create_table "true_skills", :force => true do |t|
    t.integer  "subject_id"
    t.string   "subject_type"
    t.float    "skill",        :default => 25.0
    t.float    "deviation",    :default => 5.0
    t.float    "activity",     :default => 1.0
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
