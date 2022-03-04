# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  get '/admin/users/export', to: 'admin/users#export', as: :admin_users_export
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
  # get 'admin/post/history', to: 'admin/posts#history', as: :admin_post_history
  # post 'versions/:id/revert', to: 'versions#revert'
end
