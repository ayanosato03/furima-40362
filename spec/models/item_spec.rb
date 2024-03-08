require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品がうまくいくとき' do
      it '必要な情報が全て存在すれば出品できる' do
        item = FactoryBot.build(:item)
        expect(@item).to be_valid
      end
    end

    context '商品出品がうまくいかないとき' do
      it '商品画像が存在しない場合出品できない' do
        item = FactoryBot.build(:item)
        item.image = nil
        item.valid?
        expect(item.errors.full_messages).to include('Image 商品画像を選択してください')
      end
      it '商品名が存在しない場合は出品できない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Name 商品名を入力してください')
      end
      it '商品の説明が存在しない場合は出品できない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Description 商品の説明を入力してください')
      end
      it 'カテゴリーの情報が存在しない場合は出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category カテゴリーを入力してください')
      end
      it '商品の状態の情報が存在しない場合は出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition 商品の状態を入力してください')
      end
      it '配送料の負担の情報が存在しない場合は出品できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping fee 配送料を入力してください')
      end
      it '発送元の地域の情報が存在しない場合は出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture 発送元の地域を入力してください')
      end
      it '発送までの日数の情報が存在しない場合は出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day 発送までの日数を入力してください')
      end
      it '価格が存在しない場合は出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は300円から9,999,999円までの範囲で設定してください')
      end

      it '価格が¥300より低い場合は出品できない' do
        @item.price = 299
        @item.errors.clear   
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は300円から9,999,999円までの範囲で設定してください')
      end
      
      it '価格が¥9,999,999より高い場合は出品できない' do
        @item.price = 10_000_000
        @item.errors.clear   
        @item.valid?
        expect(@item.errors.full_messages).to include('Price 価格は300円から9,999,999円までの範囲で設定してください')
      end

      it '価格が半角数値でないと保存できない' do
        @item.price = '３００' # 全角数字を代入
        @item.valid?
        expect(@item.errors[:price]).to include('is not a number')
      end

        it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
