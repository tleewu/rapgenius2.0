Rails.application.routes.draw do

  resource :user, only: [:create,:new,:show]
  resource :session, only: [:create,:new,:destroy]

  resources :bands
  resources :albums, except: :index
  resources :tracks, except: :index do
    resources :notes
  end

end
