class CreateTownStoriesTownStories < ActiveRecord::Migration

  def up
  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-town_stories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/town_stories/town_stories"})
    end
  end

end
