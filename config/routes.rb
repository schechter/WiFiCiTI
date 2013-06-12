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

end
