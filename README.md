# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| name               | string | null: false |
| name_kana          | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :selling_transactions, class_name: 'Transaction', foreign_key: 'seller_id'
- has_many :buying_transactions, class_name: 'Transaction', foreign_key: 'buyer_id'
- has_one :address

## Items テーブル
| Column             | Type        | Options     |
| ------------------ | ------------| ----------- |
| name               | string      | null: false |
| description        | text        | null: false |
| category           | references  | null: foreign_key:true |
| condition          | string      | null: false |
| shipping_fee       | string      | null: false |
| shipping_area      | string      | null: false |
| shipping_days      | string      | null: false |
| price              | integer     | null: false |
| user               | references  | null: foreign_key:true |

### Association
- belongs_to :user
- has_and_belongs_to_many :categories, through: :item_categories
- has_one :transaction

## Categories テーブル
| Column             | Type        | Options     |
| ------------------ | ------------| ----------- |
| name               | string      | null: false |

### Association
- has_and_belongs_to_many :items, through: :item_categories

## Item_categories テーブル
| Column             | Type        | Options     |
| ------------------ | ------------| ----------- |
| item               | references  | null: foreign_key:true |
| category           | references  | null: foreign_key:true |

### Association
- belongs_to :item
- belongs_to :category 


## Transactions テーブル
| Column             | Type        | Options     |
| ------------------ | ------------| ----------- |
| seller             | references  | null: foreign_key:{ to_table: :users } |
| buyer              | references  | null: foreign_key:{ to_table: :users } | |
| item               | references  | null: foreign_key:true |

### Association
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- belongs_to :item

## Addresses テーブル
| Column             | Type        | Options     |
| ------------------ | ------------| ----------- |
| post_code          | string      | null: false |
| prefectures        | string      | null: false |
| municipalities     | string      | null: false |
| street_address     | string      | null: false |
| building_name      | string      |             |
| phone_number       | integer     | null: false |
| transaction        | references  | null: foreign_key:true |

### Association
- belongs_to :transaction
