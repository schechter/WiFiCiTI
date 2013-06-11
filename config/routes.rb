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
    end
  end

  root to: 'hotspots#index'

end
