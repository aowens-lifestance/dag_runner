class CreateCatFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :cat_foods do |t|
      t.string :text

      t.timestamps
    end
  end
end
