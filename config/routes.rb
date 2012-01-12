::Refinery::Application.routes.draw do
  resources :town_stories, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :town_stories, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
