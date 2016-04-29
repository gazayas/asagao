class ModifyMembers < ActiveRecord::Migration
  def change

    # members というテーブルのカラムが変えたい時は、ここの中にメソッドを記述していきます
    # 例えば、電話番号を追加できる
    # add_column :members, :phone, :string

    # カラムも削除したり、名前を変更したりできる
    # 教科書の 4.2 (マイグレーションの詳細) を参照してください

  end
end
