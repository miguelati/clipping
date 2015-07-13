class CreateSourceCovers < ActiveRecord::Migration
  def change
    create_table :source_covers do |t|
      t.references :source
      t.references :shipping
      t.string :image_cover

      t.timestamps
    end
  end
end
