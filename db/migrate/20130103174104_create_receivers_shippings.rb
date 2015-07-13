class CreateReceiversShippings < ActiveRecord::Migration
  def up
		create_table :receivers_shippings, id: false do |t|
			t.references :receiver
			t.references :shipping
		end
		
		add_index :receivers_shippings, [:receiver_id, :shipping_id]
		add_index :receivers_shippings, [:shipping_id, :receiver_id]
  end

  def down
		drop_table :receivers_shippings
  end
end
