module Refinery
  module TownStories
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::TownStories
      engine_name :refinery_town_stories

      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.autoload_paths << File.expand_path('../', __FILE__)

      initializer "register refinerycms_town_stories plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "town_stories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.town_stories_admin_town_stories_path }
          plugin.pathname = root
          # plugin.activity = {
            # :class_name => :'refinery/town_stories/town_story'
          # }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::TownStories)
      end
    end
  end
end
