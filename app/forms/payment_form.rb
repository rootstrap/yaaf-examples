class PaymentForm < ApplicationForm
  attr_accessor :account_transaction,
                :processor_token,
                :coupon,
                :user

  before_save :decrease_stock
  before_save :mark_coupon_as_used
  after_save :update_account_transaction
  after_save :charge!

  validate :product_must_have_stock
  validate :coupon_must_not_be_used

  def initialize(args = {})
    super(args)

    @models = [payment]
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
    return if @coupon.nil? || @coupon.used?

    coupon.update!(used_by_id: user.id)
  end

  def payment
    @payment ||= AccountTransaction.new(
      amount_cents: account_transaction.amount_cents,
      user: user
    )
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
