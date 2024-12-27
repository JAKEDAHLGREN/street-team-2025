class CreateAssignments < ActiveRecord::Migration[7.2]
  def change
    create_table :assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :area
      t.string :business_name
      t.boolean :wave_one
      t.boolean :wave_two
      t.boolean :wave_three
      t.boolean :other
      t.text :notes

      t.timestamps
    end
  end
end
