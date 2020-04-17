class AccountTransactionsController < ApplicationController
  before_action :authenticate_user

  def new
    @payment_form = PaymentForm.new(
      account_transaction: transaction_to_pay,
      coupon: coupon,
      user: current_user
    )
  end

  def create
    @payment_form = PaymentForm.new(
      account_transaction: transaction_to_pay,
      coupon: coupon,
      user: current_user
    )

    # do some authorization checks

    if @payment_form.save
      redirect_to root_path, notice: 'Payment successfully received'
    else
      render :new
    end
  end

  private

  def account_transaction_params
    params.require(:account_transaction).permit(:processor_token, :coupon_code)
  end

  def authenticate_user
    return if user_signed_in?

    sign_in(
      User.first_or_create(first_name: 'John', last_name: 'Lennon', email: 'john@example.com')
    )
  end

  def coupon
    @coupon ||= Coupon.find_by!(code: coupon_code) if coupon_code
  end

  def coupon_code
    params.dig(:account_transaction, :coupon_code)
  end

  def transaction_to_pay
    @transaction_to_pay ||= AccountTransaction.first_or_create!(
      amount_cents: 15000, paid_by_id: nil, product: product, user: current_user
    )
  end

  def product
    @product ||= Product.first_or_create(name: 'Something', stock: 10)
  end
end
