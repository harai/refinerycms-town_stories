class TownStoriesController < ApplicationController

  before_filter :find_all_town_stories
  before_filter :find_page

  def index
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @town_story in the line below:
    present(@page)
  end

  def show
    @town_story = TownStory.find(params[:id])

    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @town_story in the line below:
    present(@page)
  end

protected

  def find_all_town_stories
    @town_stories = TownStory.order('position ASC')
  end

  def find_page
    @page = Page.where(:link_url => "/town_stories").first
  end

end
