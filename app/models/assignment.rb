# ActiveRecord::Schema[8.1].define(version: 2024_12_26_164211) do
#   # These are extensions that must be enabled in order to support this database
#   enable_extension "pg_catalog.plpgsql"

#   create_table "users", force: :cascade do |t|
#     t.string "email", default: "", null: false
#     t.string "encrypted_password", default: "", null: false
#     t.string "reset_password_token"
#     t.datetime "reset_password_sent_at"
#     t.datetime "remember_created_at"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.integer "role", default: 0
#     t.index ["email"], name: "index_users_on_email", unique: true
#     t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
#   end
# end

class Assignment < ApplicationRecord
  belongs_to :user
  validates :user, :business_name, :area, presence: true

  before_validation :convert_boolean_attributes

  private

  def convert_boolean_attributes
    self.wave_one = ActiveModel::Type::Boolean.new.cast(wave_one)
    self.wave_two = ActiveModel::Type::Boolean.new.cast(wave_two)
    self.wave_three = ActiveModel::Type::Boolean.new.cast(wave_three)
    self.other = ActiveModel::Type::Boolean.new.cast(other)
  end

  ransacker :user_full_name do |parent|
    Arel.sql("CONCAT(users.last_name, ' ', users.first_name)")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[area business_name created_at id id_value notes other updated_at user_id wave_one
       wave_three wave_two]
  end

  # Ransack needs to be told which associated models are searchable
  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end
