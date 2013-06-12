HotspotApp::Application.routes.draw do

	resources :users do
    collection do
      get 'find_me'
    end
  end

  resources :ratings
  resources :hotspots do
    collection do
      get 'seed'
      get 'map_generator'
    end
  end

  root to: 'static_pages#home'

  resources :sessions #temp for testing..remove me for producion

  get '/login' => 'sessions#new'
  post 'sessons' => 'sessions#create'
  match '/logout' => 'sessions#destroy'
  post 'update_location' => 'sessions#update'

end
