module Refinery
  module TownStoryArticles
    class TownStoryArticle
      class Location
        attr_reader :lat, :lng
        
        def initialize(lat, lng)
          @lat, @lng = lat, lng
        end
  
        def mongoize
          [ @lat, @lng ]
        end

        class << self
          def mongoize(obj)
            case obj
            when Location then obj.mongoize
            when Hash then Location.new(obj[:lat], obj[:lng]).mongoize
            else obj
            end
          end
  
          def demongoize(obj)
            Location.new(obj[0], obj[1])
          end
  
          def evolve(obj)
            case obj
            when Location then obj.mongoize
            else obj
            end
          end
        end
      end

      include Mongoid::Document
      include Mongoid::Timestamps

      paginates_per 30

      field :title, type: String
      field :text, type: String
      field :photos, type: Array, default: []
      field :note, type: String
      field :address, type: String
      field :location, type: Location, default: Location.new(nil, nil)
      
      attr_accessible :title, :text, :photos, :note, :address, :location
    
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
