Stripe.api_key             = ENV['STRIPE_SECRET_KEY']    
StripeEvent.signing_secret = ENV['STRIPE_SIGNING_SECRET']

StripeEvent.configure do |events|
  events.subscribe 'charge.failed' do |event|
    event.class       #=> Stripe::Event
    event.type        #=> "charge.failed"
    event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  end 


  events.all do |event|
  	#handle all events

  end
end