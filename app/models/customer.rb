class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cart_items, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :orders, dependent: :destroy

  with_options presence: true, format: { with:/\A[ぁ-んァ-ン一-龥]/ } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with:/\A[ァ-ヶー－]+\z/, message: '全角カタカナで入力してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :phonenumber, uniqueness: true, format: { with: /\A\d{10,11}\z/ }
  validates :postcode, format: {with: /\A\d{7}\z/}, numericality: { only_integer: true }

end
