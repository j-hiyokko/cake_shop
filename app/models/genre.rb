class Genre < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :genre_name, presence: true, uniqueness: true
end

