class TownStory < ActiveRecord::Base

  acts_as_indexed :fields => [:dummy]

  validates :dummy, :presence => true, :uniqueness => true
  
end
