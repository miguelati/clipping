class CreateShippings < ActiveRecord::Migration
  def change
    create_table :shippings do |t|
      t.string :name
			t.references :user
			t.references :entity
      t.integer :total
      t.integer :processed
      t.datetime :begin_at
      t.datetime :end_at
      t.string :state
      t.boolean :active

      t.timestamps
    end
  end
end
