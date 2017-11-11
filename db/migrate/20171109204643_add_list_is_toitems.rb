class AddListIsToitems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :list_id, :integer
  end
end
