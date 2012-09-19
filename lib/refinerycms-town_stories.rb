require 'refinerycms-base'
require 'mongoid'
require File.expand_path('../mongo_form_helpers', __FILE__)

module Refinery
  module TownStories

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.autoload_paths << File.expand_path('../', __FILE__)

      config.after_initialize do

        Refinery::Plugin.register do |plugin|
          plugin.name = "town_story_articles"
          plugin.pathname = root
          # plugin.activity = {
            # :class => TownStoryArticle,
            # :title => 'title'
          # }
        end
      end
    end
  end
end
