class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum user_status: { false: 0, true: 1 }

  with_options presence: true, format: { with:/\A[ぁ-んァ-ン一-龥]/, message: '日本語で入力してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with:/\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :phonenumber, uniqueness: true, format: { with: /\A\d{10,11}\z/ }
  validates :postcode, format: {with: /\A\d{7}\z/}, numericality: { only_integer: true }

  validates :address, presence: true

  def self.looks(search, word)
    where("last_name LIKE? OR first_name LIKE? OR last_name_kana LIKE? OR first_name_kana LIKE?", "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
  end

end
