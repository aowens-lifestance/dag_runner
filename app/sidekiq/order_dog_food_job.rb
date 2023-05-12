class OrderDogFoodJob
  include Sidekiq::Job
  # sidekiq_options queue: 'batches'

  def perform(*args)
    order_time = Time.zone.now

    batch = Sidekiq::Batch.new
    batch_id = batch.bid
    
    # Rails.cache.write(batch_id, 'running')
    # Don't do this, use something better than this
    @@status = 'running'

    batch.on(:complete, self.class, 'bid' => batch.bid)
    batch.jobs do
      10.times do
        OrderDogToysJob.perform_async
      end
    end
    # sleep(1) until Rails.cache.read(batch.bid) == 'complete'
    # Don't do this, use something better than this
    sleep(1) until @@status == 'complete'
    finish_time = Time.zone.now

    elapsed_time = finish_time - order_time
    DogFood.create(text: "Dog food ordered at #{order_time}, with a sleep time of #{elapsed_time} seconds")
  end

  def on_complete(status, options)
    puts 'Batch processing ended'
    # Rails.cache.write(options['bid'], 'complete')
    # Don't do this, use something better than this
    @@status = 'complete'
  end
end
