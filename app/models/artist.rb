class Artist < ActiveRecord::Base
  has_many :songs
  
  validates_presence_of :name
end
