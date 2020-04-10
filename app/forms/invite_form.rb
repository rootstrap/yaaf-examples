class InviteForm < ApplicationForm
  attr_accessor :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def initialize(args = {})
    super(args)

    @models = [invite]
  end

  private

  def invite
    @invite ||= Invite.new(invited_user_email: email)
  end
end
