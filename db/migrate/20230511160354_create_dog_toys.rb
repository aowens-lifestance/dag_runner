class CreateDogToys < ActiveRecord::Migration[6.1]
  def change
    create_table :dog_toys do |t|
      t.string :text

      t.timestamps
    end
  end
end
