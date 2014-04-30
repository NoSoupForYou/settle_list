class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string      :title
      t.integer     :duration
      t.references  :artist

      t.timestamps
    end
  end
end
