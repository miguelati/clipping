class AddIndividualsToShipping < ActiveRecord::Migration
  def change
    add_column :shippings, :individuals, :string
  end
end
