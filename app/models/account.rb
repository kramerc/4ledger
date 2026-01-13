class Account < ApplicationRecord
  belongs_to :user
  has_one :simplefin_account, dependent: :nullify

  enum :kind, { asset: 0, liability: 1, equity: 2 }
end
