class OrderAllFoodJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info("Step 1 - setting up the DAG")
    graph = Dagwood::DependencyGraph.new(
      OrderDogFoodJob: [],
      OrderCatFoodJob: %i[OrderDogFoodJob],
      OrderRodentFoodJob: []
    )

    order_of_operations = graph.parallel_order
    Rails.logger.info("Step 2 - Set parallelized order of operations")
    Rails.logger.info(order_of_operations)

    order_of_operations.each do |item|
      ItemRunner.run_item(item)
    end

    time = Time.zone.now

    OrderMessage.create(text: "All food successfully ordered at #{time}")
  end
end

class ItemRunner
  def self.run_item(item)
    item.each do |unit|
      klass_name = unit.to_s.constantize

      Rails.logger.info("Running #{klass_name}")

      klass_name.new.perform

      Rails.logger.info("#{klass_name} complete")
    end
  end
end
