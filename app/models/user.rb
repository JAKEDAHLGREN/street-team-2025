# frozen_string_literal: true

# ActiveRecord::Schema[8.1].define(version: 2024_12_26_164211) do
#   # These are extensions that must be enabled in order to support this database
#   enable_extension "pg_catalog.plpgsql"

# create_table "users", force: :cascade do |t|
#   t.string "email", default: "", null: false
#   t.string "encrypted_password", default: "", null: false
#   t.string "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer "role", default: 0
#   t.string "first_name"
#   t.string "last_name"
#   t.index ["email"], name: "index_users_on_email", unique: true
#   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
# end

class User < ApplicationRecord
  enum :role, { user: 0, admin: 1 }
  has_many :assignments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def full_name
    "#{first_name} #{last_name}"
  end

  # Ransack alias for full_name sorting
  ransacker :full_name do
    Arel.sql("CONCAT(users.first_name, ' ', users.last_name)")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[email first_name last_name full_name id last_name role]
  end

  def self.ransackable_associations(auth_object = nil)
    ['assignments']
  end
end
