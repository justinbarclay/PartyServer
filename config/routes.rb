Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api do
    constraints format: :json do
      post         'parts',                   to: 'parts#create'
      get          'parts/:id',               to: 'parts#show'
      put          'parts/:id',               to: 'parts#update'
      get          'parts',                   to: 'parts#index'
      delete       'parts/:id',               to: 'parts#delete'
    end
  end
end
