module Refinery
  module TownStoryArticles
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::TownStoryArticles
      engine_name :refinery_town_stories

      initializer "register refinerycms_town_story_articles plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "town_story_articles"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.town_story_articles_admin_town_story_articles_path }
          plugin.pathname = root
          # plugin.activity = {
            # :class_name => :'refinery/town_story_articles/town_story_article'
          # }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::TownStoryArticles)
      end
    end
  end
end
