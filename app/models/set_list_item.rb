class SetListItem < ActiveRecord::Base
  belongs_to :set_list
  belongs_to :song

  acts_as_list scope: :set_list
end
