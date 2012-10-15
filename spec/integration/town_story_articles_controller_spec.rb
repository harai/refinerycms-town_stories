require 'spec_helper'

describe 'TownStoryArticlesController', type: :request do

  before(:each) do
    TownStoryArticle.destroy_all
    user = FactoryGirl.create :refinery_user
    login_as user
  end

  it 'can access to the index page', js: true do
    page.visit('/refinery/town_story_articles/')
    page.should have_content('Town Story Articles')
  end
end
