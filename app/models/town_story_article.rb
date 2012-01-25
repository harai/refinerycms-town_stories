class TownStoryArticle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, :type => String
  field :text, :type => String
  
  attr_accessible :title, :text

  validates_presence_of :title
end
