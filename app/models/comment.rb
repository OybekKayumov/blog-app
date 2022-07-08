class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, class_name: 'Post'

  validates :text, presence: true, length: { in: 3..250 }

  after_save :update_comments_counter

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
