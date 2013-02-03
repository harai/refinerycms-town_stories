# This migration comes from refinery_town_stories (originally 1)
class CreateTownStoriesTownStories < ActiveRecord::Migration

  def up
    create_table :refinery_town_stories do |t|
      t.string :title
      t.text :text
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-town_stories"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/town_stories/town_stories"})
    end

    drop_table :refinery_town_stories

  end

end
