Rails.application.routes.draw do
  root to: 'rooms#show'

  mount ActionCable.server => '/cable'
end
