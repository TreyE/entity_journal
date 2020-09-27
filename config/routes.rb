Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :entity_update_notifications, only: [:index, :new, :create]

  root "entity_update_notifications#index"
end
