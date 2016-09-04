class Article < ApplicationRecord
  belongs_to :user

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]

  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :title, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 255 }
  validates :text, presence: true
end
