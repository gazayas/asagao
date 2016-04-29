class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|

      # $ rake db:migrate:status で現在のマイグレーションバージョンを確認できる
      # 「up印が付いているのが実行済みのマイグレーションです。」
      # 「インデックス」も必須みたいで、そちらの方も確認してください

      # 以下のもの（timestamps 以外）を追加しました
      t.integer :number, null: false
      t.string :name, null: false
      t.string :full_name
      t.string :email
      t.date :birthday
      t.integer :gender, null: false, default: 0
      t.boolean :administrator, null: false, default: false


      t.timestamps null: false
    end
  end
end
