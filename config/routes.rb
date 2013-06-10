HotspotApp::Application.routes.draw do

	resources :users
  resources :ratings
  resources :hotspots do
    collection do
      get 'seed'
    end
  end

  root to: 'hotspots#index'

end
