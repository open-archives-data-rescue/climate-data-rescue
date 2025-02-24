class RemoveForeignLink < ActiveRecord::Migration[7.0]
  def up
    remove_column :static_pages, :foreign_link
  end
  def down
  end
end
