class Instagram < ApplicationRecord

  mount_uploader :image,ImageUploader

  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites,source: :user

  validates :content,presence: true
  validates :image,presence: true
  validates :content, length: { maximum: 100 }

end
