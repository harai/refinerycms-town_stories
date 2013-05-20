require 'spec_helper'

require File.expand_path('../../../../../support/util', __FILE__)

describe Refinery do
  describe 'TownStoryArticles' do
    describe 'Admin' do
      describe 'town_story_articles', type: :feature, js: true do
        before :each do
          ::Refinery::TownStoryArticles::TownStoryArticle.destroy_all
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
            page.should have_content('Private Note')
            page.should have_content('Location')
            page.should have_content('Address')
          end
        
          it 'can access to bulk upload page' do
            click_on 'Upload CSV Files'
            page.should have_content('Drop CSV Files Here')
          end
        
          it 'can edit the existing article' do
            click_on 'Application_edit'
            page.should have_field('Title', with: 'Sample Article')
            page.should have_field('Text', with: 'Sample text.')
            find(:xpath, "id(\'town_story_article_photos\')/div[2]").should have_xpath('./img')
            page.should have_field('Private Note', with: 'Sample note')
            page.should have_content('Location')
            # cannot test them because they are hidden fields
            #
            # page.should have_field('lat', with: 35)
            # page.should have_field('lng', with: 139)
            page.should have_field('Address', with: 'Tokyo')
          end
        end
      
        describe 'paging' do
          per = ::Refinery::TownStoryArticles::TownStoryArticle.default_per_page
          before :each do
            (1..(per + 1)).each do |i|
              FactoryGirl.create :town_story_article, title: "article_#{i}"
            end 
            visit '/refinery/town_story_articles/'
          end
      
          it 'can limit the number of items in a page' do
            page.should have_xpath("id('sortable_list')/li[#{per}]")
            page.should have_no_xpath("id('sortable_list')/li[#{per + 1}]")
          end
      
          it 'can access to the next, previous, last, and first page' do
            click_on 'Next'
            page.should have_xpath("id('sortable_list')/li[1]")
            page.should have_no_xpath("id('sortable_list')/li[2]")

            click_on 'Prev'
            page.should have_xpath("id('sortable_list')/li[#{per}]")
            page.should have_no_xpath("id('sortable_list')/li[#{per + 1}]")

            click_on 'Last'
            page.should have_xpath("id('sortable_list')/li[1]")
            page.should have_no_xpath("id('sortable_list')/li[2]")

            click_on 'First'
            page.should have_xpath("id('sortable_list')/li[#{per}]")
            page.should have_no_xpath("id('sortable_list')/li[#{per + 1}]")
          end
        end
      
        describe 'new page' do
          before :each do
            visit '/refinery/town_story_articles/new'
          end
      
          it 'can create new item' do
            fill_in 'Title', with: 'Hoge Slope'
            fill_in 'Text', with: 'Too steep.'
            fill_in 'Private Note', with: 'detail needed'
            fill_in 'Address', with: 'Akihabara'
            # fill_in 'lat', with: 36
            # fill_in 'lng', with: 140
            click_on 'Save'
            page.should have_content('Hoge Slope')
            click_on 'Application_edit'
            page.should have_field('Title', with: 'Hoge Slope')
            page.should have_field('Text', with: 'Too steep.')
            page.should have_field('Address', with: 'Akihabara')
            # page.should have_field('lat', with: 36)
            # page.should have_field('lng', with: 140)
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
            click_on 'Save'
            page.should have_no_content('Sample Article')
            page.should have_content('Hoge Slope')
          end
      
          it 'can upload photos' do
            res = File.expand_path('../../../../../support/resources', __FILE__)
            Capybara.using_wait_time(60) do
              drop_files([ res + '/photo1.jpg', res + '/photo2.jpg' ], 'dropping_area')
              find(:xpath, "id(\'town_story_article_photos\')/div[3]").should have_xpath('./img')
              find(:xpath, "id(\'town_story_article_photos\')/div[3]").should have_xpath('./input')
              find(:xpath, "id(\'town_story_article_photos\')/div[4]").should have_xpath('./img')
              find(:xpath, "id(\'town_story_article_photos\')/div[4]").should have_xpath('./input')
              find(:xpath, "id(\'town_story_article_photos\')/div[5]").should have_no_xpath('./img')
              find(:xpath, "id(\'town_story_article_photos\')/div[5]").should have_no_xpath('./input')
            end
            click_on 'Save'
            click_on 'Application_edit'
            
            find(:xpath, "id(\'town_story_article_photos\')/div[3]").should have_xpath('./img')
            find(:xpath, "id(\'town_story_article_photos\')/div[3]").should have_xpath('./input')
            find(:xpath, "id(\'town_story_article_photos\')/div[4]").should have_xpath('./img')
            find(:xpath, "id(\'town_story_article_photos\')/div[4]").should have_xpath('./input')
            find(:xpath, "id(\'town_story_article_photos\')/div[5]").should have_no_xpath('./img')
            find(:xpath, "id(\'town_story_article_photos\')/div[5]").should have_no_xpath('./input')
          end
        end
      
        describe 'bulk upload' do
          before :each do
            visit '/refinery/town_story_articles/bulk_upload'
          end
      
          it 'can upload CSV files' do
            file = File.expand_path('../../../../../support/resources/articles.csv', __FILE__)
            Capybara.using_wait_time(3) do
              drop_files([ file ], 'bulk_drop')
              find(:xpath, "id(\'result\')/div[1]").should have_content('2 articles inserted.')
            end
            visit '/refinery/town_story_articles/'
            page.should have_content('Slope1')
            page.should have_content('Slope2')
          end
        end
      end
    end
  end
end
