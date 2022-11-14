# README

This is a sample application using the Dagwood gem to set up a DAG (Directed Acyclic Graph) running that will allow us to schedule/order/block sidekiq jobs so we aren't dependent on a series of cron-jobs with 'guessed' timing, and can simply set of a master job that handles the dependencies/order etc.

The "magic" in this is in the app/sidekiq/order_all_food_job.rb

Otherwise, it's a normal rails all, with the entry point being `localhost:3000/orders`
