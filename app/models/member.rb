class Member < ActiveRecord::Base
	include EmailAddressChecker

	# validates 文を書いても、view の中にエラーメッセージを表示しないと
	# それは配列として出てくると思う

	# エラーの view の片テンプレートを作る。views/shared の中に _errors.html.erb を。
	validates :number, presence: true,
						numericality: {only_integer: true,
										greater_than: 0,
										less_than:100},
						uniqueness: true


		validates :name, presence: true,
					     format: {with: /\A[A-Za-z]\w*\z/,
					              allow_blank: true,
					              message: :invalid_member_name}, #これは i18n と関係がある（ja.ymlを見て）
					     length: {minimum: 2,
					              maximum: 20,
					              allow_blank: true},
					      uniqueness: {case_sensitive: false}

		validates :full_name, length: {maximum: 20}


		# これは下にある def check_email を行わせて、
		# その中にある well_formed_as_email_address(email)をする
		# これは app/lib の中にある email_address_checker.rb を実行して、
		# そのファイルは rails の教科書の筆者によって作られたファイルです。
		# 教科書の 6.3 を参考にしてください
		validate :check_email

		validates :password, presence: {on: :create},
							confirmation: {allow_blank: true}

  attr_accessor :password, :password_confirmation # 8.2 で追加した

	def password=(val)
		if val.present?
			self.hashed_password = BCrypt::Password.create(val)
		end
		@password = val
	end


	private
	def check_email
		if email.present?
			errors.add(:email, :invalid) unless well_formed_as_email_address(email)
		end
	end




	class << self

		def search(query)
			rel = order("number")
				# .present? や .blank? が全ての rails のオブジェクトで使えるらしい
				if query.present?
					# 教科書と違って name と full_name を逆にした
					rel = where("full_name LIKE ? OR name LIKE ?",
					"%#{query}%", "%#{query}") # これはおそらく scanf("%d", x); みたな感じ？
				end
			rel
		end

		def authenticate(name, password)
			member = find_by(name: name)
			# BCrypt::Password... の 「==」は、文字列の比較ではないことに注意してください。
			# この==は、「暗号化されたパスワード」と「生のパスワードを暗号化した結果」を
			# 比較するBCrypt::Passwordのメソッドです。
			if member && member.hashed_password.present? && BCrypt::Password.new(member.hashed_password) == password
				member
			else
				nil
			end
		end

	end # class << self の終わり
end # モデルの終わり
