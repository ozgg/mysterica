# frozen_string_literal: true

# Create table for DreamPattern model
class CreateDreamPatterns < ActiveRecord::Migration[8.0]
  def change
    create_table :dream_patterns, comment: 'Common dream patterns' do |t|
      t.uuid :uuid, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :summary, null: false, default: '', comment: 'Summary of interpretation in a couple of sentences'
      t.text :description, null: false, comment: 'Detailed description of interpretation'
      t.timestamps
    end

    add_index :dream_patterns, 'lower(name)', unique: true
  end
end
