Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"
  resources :posts do  
    member do 
      post :replies, :controller => 'replies', :action => 'create'    
    end
  end
  resources :users, except: [:index, :new, :create, :destroy] do 
    member do
      get :profile 
    end
  end


  namespace :admin do 
    root "home#index"
    resources :posts
    resources :categories, except: [:show]
    resources :users, only: [:index] do 
      member do
        post :update
      end
    end
  end
end
