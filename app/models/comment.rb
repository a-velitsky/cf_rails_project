class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  
  scope :rating_desc, -> {order(rating: :desc)}

  validates :body, presence: { message: 'Comment cannot be blank!'}
  validates :user, presence: true
  validates :product, presence: true
  validates :rating, numericality: { :in => 0..5, 
  	message: 'Comment must have product rating from 1 to 5 stars!'}
  	after_create_commit { CommentUpdateJob.perform_later(self, @user) }
end