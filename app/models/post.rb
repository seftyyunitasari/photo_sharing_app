class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  mount_uploader :content, ImageUploader
end
