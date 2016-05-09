class CreateMemberImages < ActiveRecord::Migration
  def change
    create_table :member_images do |t|

      t.references :member, null: false # 外部キー
      t.binary :data # 田像データ
      t.string :content_type

      t.timestamps null: false
    end

    add_index :member_images, :member_id

  end
end
