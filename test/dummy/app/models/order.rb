class Order < ActiveRecord::Base
  validate :order_paid, before: [:ship]

  def ship
    update_column(:status, 'shipped')
  end

  def order_paid
    errors.add(:base, 'not paid')
  end
end
