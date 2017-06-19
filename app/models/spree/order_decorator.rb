# Customize Step
# http://guides.spreecommerce.org/developer/checkout.html#the-checkout-flow-dsl
Spree::Order.class_eval do
  # Spree::PermittedAttributes.checkout_attributes << :send_mail
  insert_checkout_step :send_mail, before: :delivery
end