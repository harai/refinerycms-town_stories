module Refinery
  module TownStoryArticles
    module Admin
      class TownStoryArticlesController < ::Refinery::AdminController
        include ::Refinery::TownStories::MongoidCrud
    
        mongoid_crudify :town_story_article, paging: false
    
        def upload_photo
          uploader = ::Refinery::TownStories::PhotoUploader.new
          uploader.store!(params[:file])
          render json: {
            thumb_url: uploader.t.url,
            large_url: uploader.url,
            id: uploader.model,
          }
        end
        
        def find_item
          @item = TownStoryArticle.find_by_id(params[:id])
        end
        
        def update_item(attr)
          attr[:photos] = [] unless attr.include?(:photos)
          @item.update_attributes attr
        end
        
        protected :find_item, :update_item
      end
    end
  end
end
