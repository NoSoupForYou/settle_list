class Song < ActiveRecord::Base
  validates_presence_of :title
  validates :duration, numericality: { greater_than_or_equal_to: 0 }
end
