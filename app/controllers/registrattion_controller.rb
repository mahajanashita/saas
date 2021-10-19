class RegistrationController <Devise::RegistrationController

	protected
	def after_sign_up_path_for(resource)
		plans_path
	end 

end