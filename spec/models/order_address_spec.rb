require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id, token: 'token_example')
  end

  describe '配送先情報の保存' do

    context '購入がうまくいくとき' do
      it '必要な情報が全て存在すれば出品できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it '郵便番号が存在しない場合保存できない' do
        @order_address.post_code = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の半角文字列以外の場合保存できない' do
        @order_address.post_code = '12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code 郵便番号は3桁-4桁の形式で入力してください")
      end

      it '都道府県が存在しない場合保存できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture 都道府県を入力してください")
      end

      it '市区町村が存在しない場合保存できない' do
        @order_address.municipalities = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Municipalities 市区町村を入力してください")
      end

      it '番地が存在しない場合保存できない' do
        @order_address.street_address = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Street address 番地を入力してください")
      end
      it '電話番号が存在しない場合保存できない' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", "Phone number 電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it '電話番号が半角数値でないと保存できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number 電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it '電話番号が10桁以上11桁以内でないと保存できない' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number 電話番号は10桁以上11桁以内の半角数値で入力してください")
      end

      it "tokenが空では登録できないこと" do
        @order_address.token = ""
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
     end

      it 'userが紐付いていないと保存できないこと' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end