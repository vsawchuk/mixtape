Rails.application.routes.draw do
  get '/songs', to: 'songs#index', as: 'songs'
end
