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
      get 'hs_near_user'
    end
  end

  root to: 'static_pages#home'

  get 'session/new' => 'session#new'
  post 'sessons' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post 'update_location' => 'sessions#update'


  get 'session/new' => 'session#new'
  post 'sessons' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post 'update_location' => 'sessions#update'


end
