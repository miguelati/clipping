class CreateReceivers < ActiveRecord::Migration
  def change
    create_table :receivers do |t|
      t.string :email
      t.string :name
			t.references :entity

      t.timestamps
    end
  end
end
