require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'すべての情報が正しく入力されていれば保存できること' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Nickname ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailには@を含めてください' do
        @user.email = 'test.example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email には@を含めてください')
      end
      it 'passwordが6文字以下では登録できない' do
        @user.password = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字と数字の両方を含まないと登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが一致しなければ登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = '1234abc'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'family_nameが空では登録できない' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end
      it 'family_nameは、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.family_name = 'family'
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name 全角文字を使用してください')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'first_nameは、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name = 'first'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name 全角文字を使用してください')
      end
      it 'kana_family_nameが空では登録できない' do
        @user.kana_family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family name は全角カタカナを使用してください')
      end
      it 'kana_family_nameは、全角（カタカナ）での入力が必須であること' do
        @user.kana_family_name = 'family'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana family name は全角カタカナを使用してください')
      end
      it 'kana_first_nameが空では登録できない' do
        @user.kana_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角カタカナを使用してください')
      end
      it 'kana_first_nameは、全角（カタカナ）での入力が必須であること' do
        @user.kana_first_name = 'first'
        @user.valid?
        expect(@user.errors.full_messages).to include('Kana first name は全角カタカナを使用してください')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include('Birthday 生年月日を入力してください')
      end
    end
  end
end
