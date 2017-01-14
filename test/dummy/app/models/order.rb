class Order < ActiveRecord::Base
  validate :order_paid, before: [:ship]
  validates :number, presence: true
  validate :order_status_is_created, on: :create

  def ship
    update_column(:status, 'shipped')
  end

  def order_paid
    errors.add(:base, 'not paid')
  end

  def order_status_is_created
    if status != 'created'
      errors.add(:status, 'status should be created')
    end
  end
end
