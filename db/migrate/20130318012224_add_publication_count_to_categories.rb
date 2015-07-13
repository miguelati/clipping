class AddPublicationCountToCategories < ActiveRecord::Migration
  def change
		add_column :categories, :publications_count, :integer, :default => 0
		Category.find_each do |category|
			category.update_attribute(:publications_count, category.publications.length)
		end
  end
end
