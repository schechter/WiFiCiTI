HotspotApp::Application.routes.draw do

  resources :ratings, :hotspots

  resources :users do
    collection do
      get 'find_me'
      post 'find_me'
    end
  end

  root to: 'static_pages#home'
  
  get '/login' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  match '/logout' => 'sessions#destroy'
end
