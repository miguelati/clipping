class CreateEntitiesUsers < ActiveRecord::Migration
  def up
		create_table :entities_users, id: false do |t|
			t.references :entity
			t.references :user
		end
		
		add_index :entities_users, [:entity_id, :user_id]
		add_index :entities_users, [:user_id, :entity_id]
  end

  def down
		drop_table :entities_users
  end
end
