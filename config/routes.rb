Rails.application.routes.draw do
  root to: 'rooms#show'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :messages, only: [:create]
    end
  end

  mount ActionCable.server => '/cable'
end
