class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :name
      t.string :url
      t.string :title_reg
      t.string :short_content_reg

      t.timestamps
    end
  end
end
