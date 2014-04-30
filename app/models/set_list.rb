class SetList < ActiveRecord::Base
  belongs_to :artist
  has_many :set_list_items, -> { order("position ASC") }
  has_many :songs, through: :set_list_items
end
