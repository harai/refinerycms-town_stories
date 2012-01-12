module NavigationHelpers
  module Refinery
    module TownStories
      def path_to(page_name)
        case page_name
        when /the list of town_stories/
          admin_town_stories_path

         when /the new town_story form/
          new_admin_town_story_path
        else
          nil
        end
      end
    end
  end
end
