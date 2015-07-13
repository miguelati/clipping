class AddPublishedAtRegToSources < ActiveRecord::Migration
  def change
		add_column :sources, :published_at_reg, :datetime
  end
end
