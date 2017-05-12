Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope :api do
    constraints format: :json do
      post         'parts',                   to: 'parts#create'
      get          'parts/:part_id',          to: 'parts#show'
      get          'parts',                   to: 'parts#index' 
    end
  end
end
