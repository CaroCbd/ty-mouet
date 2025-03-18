require 'sidekiq/web'

Rails.application.routes.draw do
  # root to: "pages#home"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "mouettes#index"

  # Check user authentication for Sidekiq
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  resources :mouettes, only: %i[show mine create new] do
    resources :bookings, only: [:create]
  end
  get "/bookings/owner/:id", to: "bookings#owner_bookings", as: "owner_bookings"
  get "/bookings/renter/:id", to: "bookings#renter_bookings", as: "renter_bookings"

  resources :bookings, only: [:show]
  patch "/bookings/owner/:id/accept", to: "bookings#accept", as: "accept_booking"
  patch "/bookings/owner/:id/reject", to: "bookings#reject", as: "reject_booking"
end
