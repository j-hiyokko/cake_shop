class Genre < ApplicationRecord
  # before_action :authenticate_user!
  has_many :items, dependent: :destroy

  validates :genre_name, presence: true
end
