class BulkInvitesForm < ApplicationForm
  # invites_attributes is needed in order to use the
  # fields_for helper with a collection
  attr_accessor :invites_params, :invites_attributes
  validate :amount_of_invites

  def initialize(args = {})
    super(args)

    @models = [filled_invites].flatten
  end

  def invites
    @invites ||= Array.new(5) do |i|
      InviteForm.new(
        invites_params&.dig(:invites_attributes, i.to_s)
      )
    end
  end

  private

  def filled_invites
    @filled_invites ||= invites.select { |invite| invite.email.present? }
  end

  def amount_of_invites
    return if filled_invites.size.between?(1, 5)

    errors[:base] << 'You need to send between one and five invites'
  end
end
