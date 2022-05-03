class Card < ApplicationRecord
  belongs_to :user

  # card_tokenはテーブルに存在しないのでatrr_accessorで指定してからバリデーションを設定する必要がある
  attr_accessor :card_token
  validates :card_token, presence: true
end
