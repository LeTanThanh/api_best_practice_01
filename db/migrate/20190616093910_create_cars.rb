class CreateCars < ActiveRecord::Migration[5.2]
  def change
    create_table :cars do |t|
      t.references :user
      t.string :name
      t.string :color
      t.string :code
      t.string :description

      t.timestamps
    end
  end
end
