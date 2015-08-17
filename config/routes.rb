Rails.application.routes.draw do

  root 'users/playlists#top_page'

  devise_for :users, :controllers => {
    :sessions => 'users/sessions',
    :registrations => 'users/registrations'
  }
  devise_for :admins, :controllers => {
    :sessions => 'admin/sessions',
    :registrations => 'admin/registrations'
  }

  scope module: :users do
    resources :playlists do
      resources :comments, only: [:index, :create, :new, :edit, :update, :destroy]
      resources :favorites, only: [:create] do
        collection do
          delete '/:user_id', controller: :favorites, action: :destroy, as: :destroy
        end
      end
      resources :musics, only: [:new, :create, :destroy] do
        collection do
          post :search
        end
      end
      collection do
        get :timeline
        get :ranking
        get :genre
        get 'genre/:id', controller: :playlists, action: :each_genre, as: :each_genre
      end
    end

    resources :users, only: [:show] do
      resources :relationships, only: [:create, :destroy]
      member do
        get :favorites
        get :follow
        get :follower
      end
    end
  end

  namespace :admin do
    resources :playlists, only: [:index, :show, :destroy] do
      resources :comments, only: [:index, :destroy]
    end
    resources :users, only: [:index, :show, :destroy]
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
