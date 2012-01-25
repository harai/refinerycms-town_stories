module Admin
  class TownStoryArticlesController < Admin::BaseController
    include Refinery::TownStories::MongoidCrud

    mongoid_crudify :town_story_article, :paging => false

  end
end
