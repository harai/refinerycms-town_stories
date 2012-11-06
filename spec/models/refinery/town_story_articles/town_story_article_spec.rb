require 'spec_helper'

module Refinery
  module TownStoryArticles
    describe TownStoryArticle do
    
      before(:each) do
        TownStoryArticle.destroy_all
      end
    
      context 'normally' do
        before do
          @a_id = (TownStoryArticle.create :title => 'A Slope', :text => 'This slope is too steep.').id
          @article = TownStoryArticle.find(@a_id)
        end
    
        it 'saves an article' do
          TownStoryArticle.count.should eq 1
        end
    
        it 'saves its title' do
          @article.title.should eq 'A Slope'
        end
    
        it 'saves its text' do
          @article.text.should eq 'This slope is too steep.'
        end
    
        it 'automatically saves its created date' do
          @article.created_at.should_not be_blank
        end
    
        it 'automatically saves its updated date' do
          @article.updated_at.should_not be_blank
        end
      end
    
      it 'cannot save an article without title' do
        article = TownStoryArticle.create :text => 'This slope is too steep.'
        article.should_not be_persisted
      end
    
      it 'cannot save an article with an empty title' do
        article = TownStoryArticle.create :title => '', :text => 'This slope is too steep.'
        article.should_not be_persisted
      end
    
      it 'can save an article without text' do
        article = TownStoryArticle.create :title => 'A Slope'
        article.should be_persisted
      end
    
      it 'cannot manually save the id' do
        article = TownStoryArticle.create :title => 'A Slope', :_id => 1
        article.id.should_not == 1
      end
    end
  end
end
