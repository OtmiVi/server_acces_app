Rails.application.routes.draw do
  devise_for :users
  resources :servers, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :referrals, only: [ :create, :show ], param: :token

  authenticated :user do
    root "servers#index", as: :authenticated_root
  end

  unauthenticated do
    devise_scope :user do
      root "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
