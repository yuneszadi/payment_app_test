class PaymentsController < ApplicationController
  def new
    if session[:customer] && session[:bank_account]
      @customer = Stripe::Customer.retrieve(session[:customer])
      @bank_account = @customer.sources.retrieve(session[:bank_account])
    else
      flash[:alert] = 'Please add a bank account to make an ACH payment.'
      redirect_to root_path
    end
  end

  def create
    amount = 500

    unless amount > 50
      flash[:alert] = 'Please enter a valid payment amount (minimum donation is $.50).'
      redirect_to new_payment_path and return
    end

    if params[:customer] && params[:bank_account]
      begin
        charge = Stripe::Charge.create(
          customer: params[:customer],
          source: params[:bank_account],
          amount: amount,
          currency: 'usd',
          description: 'Payment from ACH example app'
        )

      rescue Stripe::StripeError => e
        flash[:alert] = e.message
        redirect_to new_payment_path
      end
    else
      flash[:alert] = 'No customer or bank account provided'
      redirect_to root_path
    end
  end

  # def index
  #   if session[:customer]
  #     @payments = Stripe::Charge.list(limit: 100, paid: true, customer: session[:customer])
  #   else
  #     flash[:alert] = 'Please add a bank account to make an ACH payment.'
  #     redirect_to root_path
  #   end
  # end

  def show
  end
end
