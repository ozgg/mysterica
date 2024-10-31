# frozen_string_literal: true

# Create table for SleepPlace model
class CreateSleepPlaces < ActiveRecord::Migration[7.2]
  def change
    create_table :sleep_places, comment: 'Places where dreams are seen' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :name, null: false
      t.timestamps
    end

    add_index :sleep_places, %i[user_id name], unique: true
  end
end
