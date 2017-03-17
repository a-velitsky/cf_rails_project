Rails.application.routes.draw do
	
  devise_for :users
  resources :products do
    resources :comments
  end
  resources :users
	root 'static_pages#landing_page'

  get 'static_pages/landing_page'

  get 'static_pages/about'

  get 'static_pages/contact'

  get 'static_pages/index'

  post 'static_pages/thank_you'

  post 'payments/create'

  mount ActionCable.server => '/cable'

  resources :orders, only: [:index, :show, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
