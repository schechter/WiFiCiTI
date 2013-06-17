HotspotApp::Application.routes.draw do

  root to: 'static_pages#home'
  resources :users do
    collection do
      get 'find_me'
      post 'find_me'
    end
  end

   #get '/hotspots' => 'hotspots#index'
   #get '/hotspots/:id' => 'hotspots#show', as: 'hotspot'
  resources :hotspots

 get '/ratings' => 'ratings#index'
 get '/ratings/new' => 'ratings#new'
 post '/ratings' => 'ratings#create'
 get 'ratings/:id' => 'ratings#show'

  get '/login' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  match '/logout' => 'sessions#destroy'
end
