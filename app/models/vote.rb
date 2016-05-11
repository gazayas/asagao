class Vote < ActiveRecord::Base

  # このクラスを 9.4 で追加した

  belongs_to :entry
  belongs_to :member

  validate do
    unless member && member.votable_for?(entry)
      errors.add(:base, :invalid)
      # 特定の属性をエラーとするのではなく、モデルオブジェクト全体にエラーを加えたいときは、
      # :baseを指定します。
    end
  end

end
