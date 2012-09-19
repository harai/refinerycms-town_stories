class TownStoryArticle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :text, type: String
  field :photos, type: Array
  
  attr_accessible :title, :text

  validates_presence_of :title
  
  def self.find_by_id(id)
    item = where(:_id => id).first
    item
  end
end
