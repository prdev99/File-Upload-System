Rails.application.routes.draw do
  devise_for :users

  resources :file_uploads

  get 'files/shared/:token', to: 'files#shared', as: :shared_file

  root "file_uploads#index"
end
