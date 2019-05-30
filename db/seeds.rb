# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:admin, email: "admin@email.com", password: "password")
user = create(:user)
merchant_1 = create(:merchant, email: "merchant@email.com", password: "pw123")
existing_user = create(:user, email: "existingemail@gmail.com")

merchant_2, merchant_3, merchant_4 = create_list(:merchant, 3)

inactive_merchant_1 = create(:inactive_merchant)
inactive_user_1 = create(:inactive_user)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
create_list(:item, 10, user: merchant_1)

inactive_item_1 = create(:inactive_item, user: merchant_1)
inactive_item_2 = create(:inactive_item, user: inactive_merchant_1)

Random.new_seed
rng = Random.new

# pending order, none fulfilled
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, price_per_item: 1, quantity: 1)
create(:order_item, order: order, item: item_2, price_per_item: 2, quantity: 1)

# pending order, partially fulfilled
order = create(:order, user: user)
create(:order_item, order: order, item: item_1, price_per_item: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price_per_item: 2, quantity: 1, created_at: (rng.rand(23)+1).days.ago, updated_at: rng.rand(23).hours.ago)

# packaged order
order = create(:packaged_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price_per_item: 1, quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, price_per_item: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# shipped order, cannot be cancelled
order = create(:shipped_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price_per_item: 1, quantity: 1, created_at: (rng.rand(3)+1).days.ago, updated_at: rng.rand(59).minutes.ago)
create(:fulfilled_order_item, order: order, item: item_2, price_per_item: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)

# cancelled order
order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_2, price_per_item: 2, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)
create(:order_item, order: order, item: item_1, price_per_item: 3, quantity: 1, created_at: (rng.rand(23)+1).hour.ago, updated_at: rng.rand(59).minutes.ago)


puts 'seed data finished'
puts "Users created: #{User.count.to_i}"
puts "Orders created: #{Order.count.to_i}"
puts "Items created: #{Item.count.to_i}"
puts "OrderItems created: #{OrderItem.count.to_i}"
