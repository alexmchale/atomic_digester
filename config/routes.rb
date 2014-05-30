AtomicDigester::Application.routes.draw do

  get 'static_pages/index'

  root :to => "static_pages#index"

  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :users do
    resources :feeds
  end

  resources :feeds
  resources :stories, only: %i( index )

end
