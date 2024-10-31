# frozen_string_literal: true

# Create table for PersonalPattern model
class CreatePersonalPatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :personal_patterns, comment: 'Personal dream patterns' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.string :name, null: false
      t.timestamps
    end

    add_index :personal_patterns, %i[user_id name], unique: true
  end
end
