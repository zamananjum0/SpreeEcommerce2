module Spree
  CheckoutController.class_eval do
    def update
      if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
        @order.temporary_address = !params[:save_user_address]
        unless @order.next
          flash[:error] = @order.errors.full_messages.join("\n")
          redirect_to(checkout_state_path(@order.state)) && return
        end
        send_mail
        if @order.completed?
          @current_order = nil
          flash.notice = Spree.t(:order_processed_successfully)
          flash['order_completed'] = true
          redirect_to completion_route
        else
          redirect_to checkout_state_path(@order.state)
        end
      else
        render :edit
      end
    end

    private
      def send_mail
        if @order.state == 'send_mail'
            thanks
        end
      end

      def thanks
        if ThanksMailer.thanks.deliver_now
          flash[:success] = 'Success'
        else
          flash[:error] = 'Failed'
        end
      rescue => e
        flash[:error] = Spree.t('mail_methods.testmail.error', e: e)
      end
  end
end