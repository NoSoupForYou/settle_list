class Song < ActiveRecord::Base
  acts_as_taggable

  belongs_to :artist

  validates_presence_of :title
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
end
