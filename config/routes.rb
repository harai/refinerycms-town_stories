Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :town_story_articles do
    resources :town_story_articles, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :town_story_articles, :path => '' do
    namespace :admin, :path => 'refinery' do
    resources :town_story_articles, :except => :show do
      collection do
        post :upload_photo
      end
    end
  end
  end

end
