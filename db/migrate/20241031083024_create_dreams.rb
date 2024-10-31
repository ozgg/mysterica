# frozen_string_literal: true

# Create table for Dream model
class CreateDreams < ActiveRecord::Migration[7.2]
  def change # rubocop:disable Metrics/MethodLength
    create_table :dreams, comment: 'Dreams' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.references :user, foreign_key: { on_update: :cascade, on_delete: :cascade }
      t.references :sleep_place, foreign_key: { on_update: :cascade, on_delete: :nullify }
      t.integer :lucidity, limit: 2, null: false, default: 0
      t.integer :privacy, limit: 2, null: false, default: 0
      t.datetime :deleted_at
      t.string :title
      t.text :body, null: false
      t.timestamps
    end

    add_index :dreams, "date_trunc('month', created_at)", name: 'dreams_created_month_idx'
  end
end
