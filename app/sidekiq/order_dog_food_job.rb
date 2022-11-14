class OrderDogFoodJob
  include Sidekiq::Job

  def perform(*args)
    order_time = Time.zone.now
    sleep_time = rand(10).to_i
    sleep(sleep_time)
    DogFood.create(text: "Dog food ordered at #{order_time}, with a sleep time of #{sleep_time} seconds")
  end
end
