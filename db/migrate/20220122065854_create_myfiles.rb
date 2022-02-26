# frozen_string_literal: true

class CreateMyfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :myfiles do |t|
      t.text :image_data
      t.string :title, null: false

      t.timestamps
    end
  end
end
