Rails.application.routes.draw do
  get '/', to: "application#index"  

  post '/login', to: "application#login"
  get '/logout', to: "application#logout"

  post '/create_user', to: "application#create_user"

  post '/create_event', to: "application#create_event"
  get '/delete_event/:id', as: 'delete_event', to: "application#delete_event"

  get '/join_event/:id', as: 'join_event', to: "application#join_event"
  get '/leave_event/:id', as: 'leave_event', to: "application#leave_event"

  post '/create_comment/:id', as: 'create_comment', to: "application#create_comment"
  get '/delete_comment/:id', as: 'delete_comment', to: "application#delete_comment"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
