Rails.application.routes.draw do

  root to: 'user#index'

  get    '/user'          => 'user#index', as: 'users'
  get    '/user/new'      => 'user#new'  , as: 'new_user'
  get    '/user/:id/edit' => 'user#edit' , as: 'edit_user'
  get    '/user/:id'      => 'user#show' , as: 'user'
  post   '/user'          => 'user#create'
  put    '/user/:id'      => 'user#update'
  patch  '/user/:id'      => 'user#update'
  delete '/user/:id'      => 'user#destroy'

  get    'session/new' => 'session#new'
  post   'session'     => 'session#create'
  delete 'session/:id' => 'session#destroy'

  get  'login'  => 'session#new'    , as: 'login'
  post 'logout' => 'session#destroy', as: 'logout'

  get  'abook/expense', as: :expense
  get  'abook/summary', as: :summary
  get  'abook/graphic', as: :graphic
  get  'abook/balance', as: :balance
  get  'abook/private', as: :private
  get  'abook/setfile', as: :setfile
  post 'abook/imports', as: :imports

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
