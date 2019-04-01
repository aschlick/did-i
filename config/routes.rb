Rails.application.routes.draw do
  devise_for :users
  root 'static#landing'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/unconfirmed' => 'static#unconfirmed'

  resources :items do
    resources :replacements
  end
end
