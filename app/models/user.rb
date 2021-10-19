class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :subscription


  after_create :setup_subcription

  


  def setup_stripe_subcription source
  	#find the subscription in database 

    plan = subscription

    #setiing qunatity
    qty = case plan

    when "small"
    	3
    when "medium"
    	9
    when "large"
    	100
    end 

    stripe_params ={
    	:description =>"Customer id:  #{ self.id }" ,
        :plan => "Premium",
        :email =>self.email,
        :source => source, #payment method
        

    }

    
       #if customer present load the account fro them and fetch them 
    if plan.stripe_customer_id.present?
    	account =Stripe::Customer.retrieve(plan.stripe_customer_id)


    else
      #if no stripe customer id is found on subscription , then create new stripe subscription
      account =Stripe::Customer.create(stripe_params)
    end
  	
    #create /update subscription
       if plan.stripe_subscription_id.present?
         subscription = Stripe::Subscription.retrieve(plan.stripe_subscription_id, items: [
         ['plan' => "Premium", "qunatity" =>qty]
         ])

       else
         subscription =Stripe::Subscription.create(customer: plan.stripe_customer_id, items: [
         ['plan' => "Premium", "qunatity" =>qty]
         ])
       end

    
    

    #update subscription in database to store stripe sub id 

    plan.update(stripe_subscription_id: subscription.id)
  end

  private

  def setup_subcription

  	Subscription.create(account_id: self.id, plan: "free", active_until: 1.month.from_now)

  end
end
