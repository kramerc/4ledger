class SimplefinAccount < ApplicationRecord
  belongs_to :account, required: false
  belongs_to :simplefin_connection
  has_many :transactions, class_name: "SimplefinTransaction", dependent: :destroy

  validates :account_id, uniqueness: true, allow_nil: true
end
