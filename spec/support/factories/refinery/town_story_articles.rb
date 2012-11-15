FactoryGirl.define do
  factory :town_story_article, class: ::Refinery::TownStoryArticles::TownStoryArticle do |a|
    a.title 'Sample Article'
  end

  factory :normal_town_story_article, parent: :town_story_article do |a|
    a.text 'Sample text.'
    a.photos [ 'dummy-dummy-dummy-0001', 'dummy-dummy-dummy-0002' ] # no images stored in S3
  end
end
