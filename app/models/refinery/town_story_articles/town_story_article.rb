module Refinery
  module TownStoryArticles
    class TownStoryArticle
      include Mongoid::Document
      include Mongoid::Timestamps

      paginates_per 30

      field :title, type: String
      field :text, type: String
      field :photos, type: Array, default: []
      field :note, type: String
      
      attr_accessible :title, :text, :photos, :note
    
      validates_presence_of :title
    
      around_save :omit_empty_field
    
      def self.find_by_id(id)
        item = where(_id: id).first
        item.photos ||= []
        item
      end
    
      def omit_empty_field
        if photos.empty?
          atomic_unsets.push(:photos)
          reset_photos! # to prevent from $set-ting 
          yield
          # restores the original value for next accesses and
          # maintains the state of ActiveModel::Dirty
          self.photos = []
        else
          yield
        end
      end
    
      protected :omit_empty_field
    end
  end
end