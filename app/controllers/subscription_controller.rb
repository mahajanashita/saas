class SubscriptionController

	def choose_plan
		plan = params[:plan]

		@subscription =Subscription.find_by_account_id(current_account.id)
		if @subscription.present? && @subscription.update(plan: plan)

			current_account.setup_stripe_subscription

		else

		end
	end


end 