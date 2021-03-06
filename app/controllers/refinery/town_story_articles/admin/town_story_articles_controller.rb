module Refinery
  module TownStoryArticles
    module Admin
      class TownStoryArticlesController < ::Refinery::AdminController
        include ::Refinery::TownStories::MongoidCrud
    
        mongoid_crudify '/refinery/town_story_articles/town_story_article', paging: true
    
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
          @item = ::Refinery::TownStoryArticles::TownStoryArticle.find_by_id(params[:id])
        end
        
        def update_item(attr)
          attr[:photos] = [] unless attr.include?(:photos)
          @item.update_attributes attr
        end
        
        protected :find_item, :update_item

        def bulk_upload
        end

        def upload_bulk
          begin
            articles = ::Refinery::TownStoryArticles::TownStoryArticle.with(safe: true).create(params[:_json])
            render json: { n: articles.size }
          rescue => e
            render json: { error: e.inspect }
          end
        end
      end
    end
  end
end
