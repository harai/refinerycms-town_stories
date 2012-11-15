class CreateTownStoryArticlesTownStoryArticles < ActiveRecord::Migration

  def up
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-town_story_articles"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/town_story_articles/town_story_articles"})
    end
  end
end
