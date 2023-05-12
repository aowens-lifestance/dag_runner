class OrderDogToysJob
    include Sidekiq::Job
  
    def perform(*args)
      order_time = Time.zone.now

      sleep_time = rand(10).to_i
      sleep(sleep_time)

      Rails.logger.info('Dog Toy ordered!')
    end
  end
  