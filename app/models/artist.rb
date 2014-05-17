class Artist < ActiveRecord::Base
  has_many :set_lists
  has_many :songs
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
