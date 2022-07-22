class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, comparison: { greater_than_or_equal_to: 0 }

  after_save :update_posts_counter
  after_destroy :update_posts_counter

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def last_five_comments
    comments.includes(:author).last(5)
  end
end
