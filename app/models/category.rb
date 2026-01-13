class Category < ApplicationRecord
  has_many :transactions, dependent: :nullify
end
