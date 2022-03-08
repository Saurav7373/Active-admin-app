# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  get '/admin/users/export', to: 'admin/users#export', as: :admin_users_export
  # for showing deleted data
  get '/admin/posts/deleted_record', to: 'admin/posts#deleted_record', as: :admin_posts_deleted_record
  # for deleteing permanently the post data
  delete '/admin/posts/destroy_data', to: 'admin/posts#destroy_data', as: :admin_posts_destroy_data
  # for undoing post
  get '/admin/posts/restore', to: 'admin/posts#restore', as: :admin_posts_restore
  # for saving versiions in paper trail
  post '/admin/posts/paper_update', to: 'admin/posts#paper_update', as: :admin_posts_paper_update


# for users
  # for showing deleted data
  get '/admin/users/deleted_record', to: 'admin/users#deleted_record', as: :admin_users_deleted_record
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
