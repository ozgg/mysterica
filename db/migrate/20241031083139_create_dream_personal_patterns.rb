# frozen_string_literal: true

# Create table for DreamPersonalPattern model
class CreateDreamPersonalPatterns < ActiveRecord::Migration[7.2]
  def change
    create_table :dream_personal_patterns, comment: 'Links between dreams and personal patterns' do |t|
      t.references :dream, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :personal_pattern, null: false, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.timestamps
    end
  end
end
