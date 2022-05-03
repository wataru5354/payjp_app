Rails.application.routes.draw do
  get 'cards/new'
  get 'users/show'
  get 'items/index'
  devise_for :users
  root 'items#index'
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  # memberとはresources以外のメソッドの追加とid情報を含むURLの生成するときに使う
  resources :items, only: :order do
    post 'order', on: :member
  end
end
