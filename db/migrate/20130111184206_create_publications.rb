class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
			t.references :category
			t.references :shipping
			t.string :title
			t.string :short_content, size: 1000
			t.string :url
			t.string :source
			t.string :source_url
			t.date   :published_at

      t.timestamps
    end
  end
end
