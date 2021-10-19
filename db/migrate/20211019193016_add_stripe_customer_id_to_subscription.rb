class AddStripeCustomerIdToSubscription < ActiveRecord::Migration[6.1]
  def change
  	add_column :subscriptions, :stripe_customer_id, :string
  end
end
