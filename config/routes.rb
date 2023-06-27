Rails.application.routes.draw do
  devise_for :users
  resources :users
  root to: 'homes#top'
  get '/home/about' => 'homes#about'
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #delete "/books/:book_id/favorites" => "favorites#destroy",as: 'favorites_delete'
    #post "/books/:book_id/favorites" => "favorites#create",as: 'favorites_post'
end
