class CreateSetLists < ActiveRecord::Migration
  def change
    create_table :set_lists do |t|
      t.string :name
      t.text :description
      t.references :artist, index: true

      t.timestamps
    end
  end
end
