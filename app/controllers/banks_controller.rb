class BanksController < ApplicationController
  def new
  end

  def create
    if params[:stripeToken]
      token = params[:stripeToken]
      begin
        if session[:customer].nil?
          customer = Stripe::Customer.create(
            source: token,
            description: 'Bank account form example customer'
          )

        else
          customer = Stripe::Customer.retrieve(session[:customer])
          customer.source = token
          customer.save
        end

        session[:customer] = customer.id
        session[:bank_account] = customer.sources.data.first.id

        flash[:success] = 'Your bank account has been connected.'
        redirect_to new_microdeposit_path
      rescue Stripe::RateLimitError => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::InvalidRequestError => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::AuthenticationError => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::APIConnectionError => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue Stripe::StripeError => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      rescue => e
        flash[:alert] = e.message
        redirect_to new_banks_path
      end
    else
      flash[:alert] = 'No stripeToken provided'
      redirect_to new_banks_path
    end
  end
end
