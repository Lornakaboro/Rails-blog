class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments
  has_many :likes

  after_save :update_posts_counter

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  scope :recent_comments, ->(post_id) { Comment.where(post_id: post_id).order(created_at: :desc).limit(5) }
end
