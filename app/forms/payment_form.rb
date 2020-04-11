class PaymentForm < ApplicationForm
  attr_accessor :account_transaction,
                :processor_token,
                :coupon,
                :user

  before_save :decrease_stock
  before_save :mark_coupon_as_used
  before_save :charge!
  after_save :update_account_transaction

  validate :product_must_have_stock
  validate :coupon_must_not_be_used

  def initialize(args = {})
    super(args)

    @models = [payment, new_coupon]
  end

  private

  #
  # This method will be called first after validations are successful
  # It calls the external payment processor service
  #
  def charge!
    PaymentProcessorService.new(
      accountr_transaction: account_transaction,
      coupon: coupon,
      token: processor_token,
      user: user
    ).charge!
  rescue PaymentProcessorError => error
    errors.add(:base, I18n.t('forms.payment_form.payment_processor_error'))
    raise(error)
  end

  def coupon_must_not_be_used
    return unless coupon&.used?

    errors.add(:coupon, I18n.t('forms.payment_form.coupon_must_not_be_used'))
  end

  def decrease_stock
    product.update!(stock: product.stock - 1)
  end

  def mark_coupon_as_used
    return if @coupon.used?

    coupon.update!(used_by_id: user.id)
  end

  #
  # Everytime the user submits a payment, they get a 5% discount coupon to share with a friend
  #
  def new_coupon
    Coupon.new(user: user, discount_type: :percentage, discount_amount: 5)
  end

  def payment
    @payment ||= AccountTransaction.new(amount: account_transaction.amount)
  end

  def product
    @product ||= account_transaction.product
  end

  def product_must_have_stock
    return unless product.stock < 1

    errors.add(:product, I18n.t('forms.payment_form.product_must_have_stock'))
  end

  #
  # To mark the debt as paid by the payment being charged here
  #
  def update_account_transaction
    account_transaction.update!(paid_by_id: payment.reload.id)
  end
end
