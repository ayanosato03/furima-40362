class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :street_address, :building_name, :phone_number, :user_id,:item_id
 
 with_options presence: true do
  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: '郵便番号は3桁-4桁の形式で入力してください' }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, message: '都道府県を入力してください' }
  validates :municipalities, presence: { message: '市区町村を入力してください' }
  validates :street_address, presence: { message: '番地を入力してください' }
  validates :building_name
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '電話番号は10桁以上11桁以内の半角数値で入力してください' }
  validates :user_id
  validates :item_id
 end

 def save
  order = Order.create(item_id: item_id, user_id: user_id)
  Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, street_address: street_address, building_name: building_name, phone_number:phone_number, order_id: order.id)
end

end