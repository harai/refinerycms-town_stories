require 'spec_helper'

require File.expand_path('../../support/util', __FILE__)

describe 'TownStoryArticlesController', type: :request, js: true do

  before(:each) do
    TownStoryArticle.destroy_all
    @user = FactoryGirl.create :refinery_user
    login_as @user
  end

  describe 'showing' do
    before :each do
      FactoryGirl.create :normal_town_story_article
      visit '/refinery/town_story_articles/'
    end

    it 'can access to the index page' do
      page.should have_content('Town Story Articles')
      page.should have_content('Sample Article')
    end
  
    it 'can access to the new page' do
      click_on 'Add New Town Story Article'
      page.should have_content('Title')
      page.should have_content('Text')
      page.should have_content('Photos')
    end
  
    it 'can edit the existing article' do
      click_on 'Application_edit'
      page.should have_field('Title', with: 'Sample Article')
      page.should have_field('Text', with: 'Sample text.')
      page.should have_xpath('id(\'town_story_article_photos\')/div[2]/img')
    end
  end

  describe 'new page' do
    before :each do
      visit '/refinery/town_story_articles/new'
    end

    it 'can create new item' do
      fill_in 'Title', with: 'Hoge Slope'
      fill_in 'Text', with: 'Too steep.'
      click_on 'Save'
      page.should have_content('Hoge Slope')
      click_on 'Application_edit'
      page.should have_field('Title', with: 'Hoge Slope')
      page.should have_field('Text', with: 'Too steep.')
    end
  end

  describe 'edit page' do
    before :each do
      FactoryGirl.create :normal_town_story_article
      visit '/refinery/town_story_articles'
      raise 'prerequisite is not fulfilled' unless page.has_content?('Sample Article')
      click_on 'Application_edit'
    end

    it 'can edit an existing item' do
      fill_in 'Title', with: 'Hoge Slope'
      fill_in 'Text', with: 'Too steep.'
      click_on 'Save'
      page.should have_no_content('Sample Article')
      page.should have_content('Hoge Slope')
      click_on 'Application_edit'
      page.should have_field('Title', with: 'Hoge Slope')
      page.should have_field('Text', with: 'Too steep.')
    end
  end
end
