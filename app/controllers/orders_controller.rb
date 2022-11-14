class OrdersController < ApplicationController
    def index
        @dog_food_orders = DogFood.all
        @cat_food_orders = CatFood.all
        @rodent_food_orders = RodentFood.all

        @order_messages = OrderMessage.all
    end

    def dog_food
        OrderDogFoodJob.perform_async
        redirect_to orders_path, flash: { alert: "Dog Food Ordered" }
    end

    def cat_food
        OrderCatFoodJob.perform_async
        redirect_to orders_path, flash: { alert: "Cat Food Ordered" }
    end

    def rodent_food
        OrderRodentFoodJob.perform_async
        redirect_to orders_path, flash: { alert: "Rodent Food Ordered" }
    end

    def all_food
        OrderAllFoodJob.perform_async
        redirect_to orders_path, flash: { alert: "All Food Ordered" }
    end

    def clear_orders
        DogFood.delete_all
        CatFood.delete_all
        RodentFood.delete_all
        OrderMessage.delete_all

        redirect_to orders_path, flash: { alert: "All Orders Deleted" }
    end
end