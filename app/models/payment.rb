class Payment < ActiveRecord::Base
  validates :correlation_id, presence: true
  validates :price, presence: true
  validates :payment_status, presence: true
end
