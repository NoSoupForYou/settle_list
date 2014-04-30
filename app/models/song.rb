class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :set_list_items
  has_many :set_lists, through: :set_list_items

  acts_as_taggable

  validates_presence_of :title
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
end
