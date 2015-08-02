Rails.application.routes.draw do

  root to: 'ship#expense'

  get    'login'           , to: 'auth#new'        , as: 'login'
  post   'logout'          , to: 'auth#destroy'    , as: 'logout'
  post   'auth'            , to: 'auth#create'
  delete 'auth/:id'        , to: 'auth#destroy'

  get    '/user'           , to: 'user#index'      , as: 'users'
  post   '/user'           , to: 'user#create'     , as: ''
  get    '/user/new'       , to: 'user#new'        , as: 'new_user'
  get    '/user/:id/edit'  , to: 'user#edit'       , as: 'edit_user'
  put    '/user/:id'       , to: 'user#update'     , as: 'user'
  patch  '/user/:id'       , to: 'user#update'     , as: ''
  delete '/user/:id'       , to: 'user#destroy'    , as: ''

  get    'ship/expense'    , to: 'ship#expense'    , as: :expense
  get    'ship/summary'    , to: 'ship#summary'    , as: :summary
  get    'ship/graphic'    , to: 'ship#graphic'    , as: :graphic
  get    'ship/balance'    , to: 'ship#balance'    , as: :balance
  get    'ship/private'    , to: 'ship#private'    , as: :private
  get    'ship/uploads'    , to: 'ship#uploads'    , as: :uploads
  post   'ship/imports'    , to: 'ship#imports'    , as: :imports

  get    'ship/pdf/summary', to: 'ship#summary_pdf', as: :summary_pdf
  get    'ship/pdf/balance', to: 'ship#balance_pdf', as: :balance_pdf

  match '*path' => 'application#error404', via: :all

end
