Rails.application.routes.draw do
  root 'articles#index'
  # get '/articles/index',to:'articles#index'
  # get "/articles/:id", to: "articles#show"
  resources :articles do
    resources :comments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
