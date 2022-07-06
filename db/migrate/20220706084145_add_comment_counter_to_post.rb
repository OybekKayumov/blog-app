class AddCommentCounterToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comment_counter, :integer
  end
end
