::Refinery::Application.routes.draw do
  resources :town_story_articles, :only => [:index, :show]

  scope :path => 'refinery', :as => 'admin', :module => 'admin' do
    resources :town_story_articles, :except => :show do
      collection do
        post :upload_photo
      end
    end
  end
end
