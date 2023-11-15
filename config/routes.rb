Rails.application.routes.draw do
  devise_for :users
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"

  # Custom routes to register/drop/view registered
  get "/users/:id/registered_courses", to: "account#index", as: :registered_courses
  post "/courses/:id/register/:user_id", to: "courses#register", as: :register_course
  delete "/courses/:id/drop/:user_id", to: "courses#drop", as: :drop_course
end
