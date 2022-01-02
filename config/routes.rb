Rails.application.routes.draw do
  resources :avatars
  root 'users#new'
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end
  resources :likes, only: [:create, :destroy, :index]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
