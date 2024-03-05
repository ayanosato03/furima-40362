require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = FactoryBot.build(:user, nickname: '')
      user.valid?
      expect(user.errors.full_messages).to include('Nickname ニックネームを入力してください')
    end
    it 'emailが空では登録できない' do
      user = FactoryBot.build(:user, email: '')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが6文字以下では登録できない' do
      user = FactoryBot.build(:user, password: '00000', password_confirmation: '00000')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが英字と数字の両方を含まないと登録できない' do
      user = FactoryBot.build(:user, password: '000000', password_confirmation: '000000')
      user.valid?
      expect(user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'family_nameが空では登録できない' do
      user = FactoryBot.build(:user, family_name: '')
      user.valid?
      expect(user.errors.full_messages).to include('Family name 全角文字を使用してください')
    end
    it 'first_nameが空では登録できない' do
      user = FactoryBot.build(:user, first_name: '')
      user.valid?
      expect(user.errors.full_messages).to include('First name 全角文字を使用してください')
    end
    it 'kana_family_nameが空では登録できない' do
      user = FactoryBot.build(:user, kana_family_name: '')
      user.valid?
      expect(user.errors.full_messages).to include('Kana family name は全角カタカナを使用してください')
    end
    it 'kana_first_nameが空では登録できない' do
      user = FactoryBot.build(:user, kana_first_name: '')
      user.valid?
      expect(user.errors.full_messages).to include('Kana first name は全角カタカナを使用してください')
    end
    it 'birthdayが空では登録できない' do
      user = FactoryBot.build(:user, birthday: nil)
    end
  end
end
