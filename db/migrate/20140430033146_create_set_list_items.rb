class CreateSetListItems < ActiveRecord::Migration
  def change
    create_table :set_list_items do |t|
      t.integer :position
      t.references :set_list, index: true
      t.references :song, index: true

      t.timestamps
    end
  end
end
