require 'refinerycms-core'

module Refinery
  autoload :TownStoriesGenerator, 'generators/refinery/town_stories_generator'

  module TownStoryArticles
    require 'refinery/town_story_articles/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
