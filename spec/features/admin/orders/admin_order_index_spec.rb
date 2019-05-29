require 'rails_helper'

RSpec.describe 'Admin Order Index', type: :feature do
  context 'as an admin' do
    it 'should display all orders and correct info' do
      admin = create(:admin)
      user_w_order_1 = create(:user)
      user_w_order_2 = create(:user)
      order_1 = create(:order, user: user_w_order_1)
      order_2 = create(:packaged_order, user: user_w_order_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_link(order_1.user.name)
      expect(page).to have_content(order_1.created_at)
      expect(page).to have_content(order_1.id)
      expect(page).to have_content(order_1.status)
      expect(page).to have_link(order_2.user.name)
      expect(page).to have_content(order_2.created_at)
      expect(page).to have_content(order_2.id)
      expect(page).to have_content(order_2.status)
    end
  end
end
