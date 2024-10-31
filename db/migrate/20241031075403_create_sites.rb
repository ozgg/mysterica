# frozen_string_literal: true

# Create table for Site model
class CreateSites < ActiveRecord::Migration[7.2]
  def change
    create_table :sites, comment: 'Sites' do |t|
      t.boolean :active, null: false, default: true
      t.uuid :uuid, null: false
      t.string :slug, collation: 'C', null: false
      t.string :token, null: false, index: { unique: true }, comment: 'Authentication token'
      t.timestamps
    end

    add_index :sites, 'lower(slug)', unique: true
  end
end
