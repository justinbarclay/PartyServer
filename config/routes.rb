Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api do
    constraints format: :json do
      post         'parts',                   to: 'parts#create'
      get          'parts/:id',               to: 'parts#show'
      post         'parts/search',            to: 'parts#search'
      put          'parts/:id',               to: 'parts#update'
      get          'parts',                   to: 'parts#index'

      delete       'parts/:id',               to: 'parts#delete'

      post         'admin/invite',            to: 'admins#invite_user'
      get          'admin/users',             to: 'admins#index'
      post         'admin/reset_password',    to: 'admins#reset_user_password'
      delete       'admin/users/:id',         to: 'admins#delete'
      get          'admin/users/:id',         to: 'admins#show'
      
      post         'signup',                  to: 'users#create'
      get          'users/:token',            to: 'users#show'
      post         'reset_password',          to: 'users#reset_password'
      post         'user_token',              to: 'user_token#create'
      post         'login',                   to: 'user_token#create'
    end
  end

  get              '/*any',                   to: 'static#index'
end
