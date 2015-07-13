class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
			t.references :entity
      t.string :name
      t.boolean :is_important

      t.timestamps
    end
  end
end
