# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: true, foreign_key: { on_delete: :nullify }, index: true
      t.string :title, null: false, limit: 50
      t.text :body

      t.timestamps
    end
  end
end
