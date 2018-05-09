Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "posts#index"
  resources :posts do  

    collection do 
      get :feeds      
    end

    member do 
      post :replies, :controller => 'replies', :action => 'create'    
      post :replies_delete, :controller => 'replies', :action => 'destroy'
      get :replies_edit, :controller => 'replies', :action => 'edit'    
      post :replies_update, :controller => 'replies', :action => 'update'    
    end
  end
  resources :users, except: [:index, :new, :create, :destroy] do 
    member do
      get :profile 
      get :comment 
      get :draft 
    end
  end

  # categories routes
  resources :categories, only: :show


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
