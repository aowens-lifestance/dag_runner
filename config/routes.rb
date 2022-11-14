require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  get 'orders', to: 'orders#index'
  get '/order_dog_food', to: 'orders#dog_food'
  get '/order_cat_food', to: 'orders#cat_food'
  get '/order_rodent_food', to: 'orders#rodent_food'
  get '/order_all_food', to: 'orders#all_food'
  get '/clear_orders', to: 'orders#clear_orders'

  get '/messages/send_success', to: 'messages#send_success_message'
  get '/messages/send_failure', to: 'messages#send_success_failure'
end
