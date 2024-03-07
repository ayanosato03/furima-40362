class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  validates :image, presence: { message: '商品画像を選択してください' }
  validates :name, presence: { message: '商品名を入力してください' }
  validates :description, presence: { message: '商品の説明を入力してください' }
  validates :category_id,      presence: true, numericality: { other_than: 1, message: 'カテゴリーを入力してください' }
  validates :condition_id,     presence: true, numericality: { other_than: 1, message: '商品の状態を入力してください' }
  validates :shipping_fee_id,  presence: true, numericality: { other_than: 1, message: '配送料を入力してください' }
  validates :prefecture_id,    presence: true, numericality: { other_than: 1, message: '発送元の地域を入力してください' }
  validates :shipping_day_id,  presence: true, numericality: { other_than: 1, message: '発送までの日数を入力してください' }
  validates :price, presence: { message: '金額を入力してください' },
                    numericality: {
                      only_integer: true,
                      greater_than_or_equal_to: 300,
                      less_than_or_equal_to: 9_999_999,
                      message: '価格は300円から9,999,999円までの範囲で設定してください'
                    }
end
