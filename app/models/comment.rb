class Comment < ApplicationRecord
  belong_to :author, class_name: 'User', foreign_key :author_id
  belong_to :post, class_name: 'Post'
end