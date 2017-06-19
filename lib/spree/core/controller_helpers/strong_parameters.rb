Spree::Core::ControllerHelpers::StrongParameters.class_eval do

   def permitted_order_attributes
     permitted_checkout_attributes + [
       :send_mail_attributes => [:send_mail],
     ]
   end

end