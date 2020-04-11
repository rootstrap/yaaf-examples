module Api
  module V1
    class BulkInvitesForm < ApplicationForm
      attr_accessor :invites_params
      validate :amount_of_invites

      def initialize(args = {})
        super(args)

        @models = [invites].flatten
      end

      private

      def invites
        @invites ||= invites_params&.dig(:invites)&.map { |invite_params| InviteForm.new(invite_params) } || []
      end

      def amount_of_invites
        return if invites.size.between?(1, 5)

        errors[:base] << 'You need to send between one and five invites'
      end

      # Override promote_errors to namespace invite errors
      def promote_errors(model)
        namespace = "invite[#{invites.find_index(model)}]" if model.is_a?(InviteForm)

        model.errors.each do |attribute, message|
          errors.add("#{namespace}[#{attribute}]", message)
        end
      end
    end
  end
end
