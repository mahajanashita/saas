Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/webhooks/stripe'
  devise_for :users, controllers: {registration: "registrations"}

  get "/plans" => "posts#plans"
  post "/plan/subscribe" => "subscriptions#choose_plan", as: :choose_plan
  root "posts#index"
  resources :posts


  
end
