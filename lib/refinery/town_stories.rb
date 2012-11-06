require 'refinerycms-core'
require 'mongoid'
require File.expand_path('../../mongo_form_helpers', __FILE__)

module Refinery
  autoload :TownStoriesGenerator, 'generators/refinery/town_stories_generator'

  module TownStories
    require 'refinery/town_stories/engine'

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
