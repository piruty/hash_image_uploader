Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :images, only: %w|index new create|
  get 'images/:hash' => 'images#download'
end
