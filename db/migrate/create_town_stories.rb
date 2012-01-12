class CreateTownStories < ActiveRecord::Migration

  def self.up
    create_table :town_stories do |t|
      t.string :dummy
      t.integer :position

      t.timestamps
    end

    add_index :town_stories, :id

    load(Rails.root.join('db', 'seeds', 'town_stories.rb'))
  end

  def self.down
    if defined?(UserPlugin)
      UserPlugin.destroy_all({:name => "town_stories"})
    end

    if defined?(Page)
      Page.delete_all({:link_url => "/town_stories"})
    end

    drop_table :town_stories
  end

end
