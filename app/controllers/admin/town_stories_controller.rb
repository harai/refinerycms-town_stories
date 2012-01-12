module Admin
  class TownStoriesController < Admin::BaseController

    crudify :town_story,
            :title_attribute => 'dummy', :xhr_paging => true

  end
end
