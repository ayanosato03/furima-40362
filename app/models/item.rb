class Item < ApplicationRecord
 belongs_to :user

 validates :name, presence: { message: '商品名を入力してください' }
 validates :description, presence: { message: '商品の説明を入力してください' }
 validates :category_id,      presence:true, numericality: { other_than: 0, message: 'カテゴリーを入力してください' }
 validates :condition_id,     presence:true, numericality: { other_than: 0, message: '商品の状態を入力してください' }
 validates :shipping_fee_id,  presence:true, numericality: { other_than: 0, message: '配送料を入力してください' }
 validates :prefecture_id,    presence:true, numericality: { other_than: 0, message: '発送元の地域を入力してください' }
 validates :shipping_day_id,  presence:true, numericality: { other_than: 0, message: '発送までの日数を入力してください' }
 validates :price, presence: { message: '金額を入力してください' }
end
