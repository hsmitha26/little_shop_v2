class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates_presence_of :email,
                        :name,
                        :address,
                        :city,
                        :state,
                        :zip,
                        :role
  has_many :orders
  has_many :items

  enum role: ['user', 'merchant', 'admin']

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password_digest

  has_secure_password

  def self.active_merchants
    where(active: true, role: 'merchant').order(:id)
  end

  def self.inactive_merchants
    where(active: false, role: 'merchant').order(:id)
  end

  def self.all_merchants
    where(role: 'merchant').order(:id)
  end

  def self.regular_users
    where(role: 'user').order(:id)
  end

  def self.top_3_by_revenue
    self.joins(items: :order_items)
        .joins("JOIN orders ON order_items.order_id = orders.id")
        .group(:id)
        .select("users.*, SUM(order_items.quantity * order_items.price_per_item) AS total_revenue")
        .where(active: true)
        .where("orders.status = 2")
        .order("total_revenue DESC")
        .limit(3)
  end

  def self.top_3_merch_by_quantity
    self.joins(items: :order_items)
        .joins("JOIN orders ON order_items.order_id = orders.id")
        .group(:id)
        .select("users.*, SUM(order_items.quantity) AS total_quantity")
        .where(active: true)
        .where("orders.status = 2")
        .order("total_quantity DESC")
        .limit(3)
  end

  def self.top_3_states
    self.joins(:orders)
        .select("users.state, count(orders) as order_count")
        .group("users.state")
        .where("orders.status = 2")
        .order("order_count DESC")
        .limit(3)
  end

  def self.top_3_cities
    thing = self.joins(:orders)
        .select("users.state, users.city, count(orders) as order_count")
        .group("users.state, users.city")
        .where("orders.status = 2")
        .order("order_count DESC")
        .limit(3)
  end

  def self.average_fulfillment_times
    self.joins(items: :order_items)
        .select("AVG(order_items.updated_at - order_items.created_at) AS avg_time, users.*")
        .group(:id)
        .where("order_items.fulfilled = true")
  end

  def self.fastest_3_merchants
    self.average_fulfillment_times.order("avg_time").limit(3)
  end

  def self.slowest_3_merchants
    self.average_fulfillment_times.order("avg_time DESC").limit(3)
  end

  def total_revenue
    items.joins(:order_items)
         .joins("JOIN orders ON order_items.order_id = orders.id")
         .where("orders.status = 2")
         .sum("order_items.quantity * order_items.price_per_item")
  end
end
