Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :yachts do
    resources :reviews, only: %i[new create]
    resources :bookings, only: %i[new create index destroy]

    collection do
      get :my_yachts
    end

    get     "/booking-success",   to: "bookings#success"
    post    "/confirm-booking",   to: "bookings#confirm"
  end

  resources :bookings, only: %i[index] do
    get "/bookings",              to: "bookings#index"
  end
end
