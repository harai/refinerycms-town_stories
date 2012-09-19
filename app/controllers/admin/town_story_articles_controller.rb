module Admin
  class TownStoryArticlesController < Admin::BaseController
    include Refinery::TownStories::MongoidCrud

    mongoid_crudify :town_story_article, paging: false

    def upload_photo
      uploader = PhotoUploader.new
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
    
    protected :find_item
  end
end
