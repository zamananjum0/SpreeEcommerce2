module Spree
  class ThanksMailer < BaseMailer
    layout 'spree/layouts/email'
    helper 'spree/base'
    def thanks
      subject = "Thank you - #{Spree::Store.current.name} #{Spree.t('test_mailer.test_email.subject')}"
      mail(to: 'vhquocminhit@gmail.com', from: from_address, subject: subject)
    end
  end
end