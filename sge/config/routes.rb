Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get '/usuarios', to: 'users#index'
      post '/usuarios', to: 'users#create'
      post '/login', to: 'users#login'
      post '/logout', to: 'users#logout'
    end
  end
end