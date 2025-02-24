class DropBtPosts < ActiveRecord::Migration[7.0]
  def change
    drop_table :better_together_posts
  end
end
