class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }

  after_create :generate_api_token

  def is?(requested_role)
    role == requested_role.to_s
  end

  def last_three_posts
    posts.order(created_at: :desc).limit(3)
  end

  def admin?
    :role == 'admin'
  end

  def generate_jwt
    JWT.encode({ id:,
                 exp: 60.days.from_now.to_i },
               Rails.application.secrets.secret_key_base)
  end

  private

  def generate_api_token
    self.api_token = Devise.friendly_token
    save
  end
end
