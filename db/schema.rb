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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140423212441) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.date     "date"
    t.string   "phase"
    t.string   "state"
    t.integer  "local_team_id"
    t.integer  "visit_team_id"
    t.integer  "local_goals"
    t.integer  "visit_goals"
    t.integer  "winner_team_id"
    t.integer  "looser_team_id"
    t.boolean  "draw?"
    t.integer  "group_id"
    t.integer  "stadium_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["group_id"], name: "index_matches_on_group_id"
  add_index "matches", ["local_team_id"], name: "index_matches_on_local_team_id"
  add_index "matches", ["looser_team_id"], name: "index_matches_on_looser_team_id"
  add_index "matches", ["stadium_id"], name: "index_matches_on_stadium_id"
  add_index "matches", ["visit_team_id"], name: "index_matches_on_visit_team_id"
  add_index "matches", ["winner_team_id"], name: "index_matches_on_winner_team_id"

  create_table "participations", force: true do |t|
    t.integer  "team_id"
    t.integer  "group_id"
    t.integer  "points"
    t.integer  "games"
    t.integer  "wins"
    t.integer  "draws"
    t.integer  "losses"
    t.integer  "goals_scored"
    t.integer  "goals_against"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participations", ["group_id"], name: "index_participations_on_group_id"
  add_index "participations", ["team_id"], name: "index_participations_on_team_id"

  create_table "stadia", force: true do |t|
    t.string   "name"
    t.string   "city"
    t.date     "construction_date"
    t.integer  "capacity"
    t.string   "photo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "coach"
    t.string   "flag"
    t.string   "uniform"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
