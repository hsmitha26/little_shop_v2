class Item < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  validates_presence_of :name,
                        :price,
                        :description,
                        :inventory

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  DEFAULT_IMAGE = "https://www.ultimate-realty.com/wp-content/uploads/sites/6518/2019/04/Image-Coming-Soon.png"

  def self.active_items
    self.where(active: true)
  end

  def self.sort_by_popularity(limit, direction)
    self.joins(:order_items)
    .select("items.*, sum(order_items.quantity) AS total_quantity")
    .where("order_items.fulfilled = true")
    .group(:id)
    .order("total_quantity #{direction.to_s}")
    .limit(limit)
  end

  def average_fulfillment_time
    order_items.average("updated_at - created_at").to_i
  end

  def order_count
    orders.count
  end

  def purchase_price(order)
    order_items.where("order_items.order_id=?", order.id)
              .first
              .price_per_item
  end

  def purchase_quantity(order)
    order_items.where("order_items.order_id=?", order.id)
              .first
              .quantity
  end
end
