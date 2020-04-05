class RegistrationForm < ApplicationForm
  attr_accessor :first_name,
                :last_name,
                :email,
                :password,
                :password_confirmation,
                :department_id

  after_save :add_role

  #
  # To let Devise treat the form object as it were the actual user object
  #
  delegate_missing_to :user

  validate :deparment_must_exist

  def initialize(args = {})
    super(args)

    @models = [user]
  end

  #
  # Override this method to let Devise know whether the form object saved the resource correctly or not
  # `delegate_missing_to :user` will not be enough because the user method has been memoized hence
  # the `persisted?` attribute will have an outdated value
  #
  def persisted?
    user.persisted?
  end

  #
  # When using the `f.submit` helper method from Simple Form, this method will be used to display the button's text
  # If this not defined it will display: "Create Registration Form"
  # Well obviously you can use a translation directly in the view to avoid overriding this method.
  #
  # def model_name
  #   User.model_name
  # end

  private

  def add_role
    user.add_role(:employee, department)
  end

  def department
    @department ||= Department.find_by(id: department_id)
  end

  def user
    @user ||= User.new(
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: password,
      password_confirmation: password_confirmation
    )
  end

  def deparment_must_exist
    return if department

    errors.add(:base, I18n.t('forms.registration_form.department_must_exist'))
  end
end
