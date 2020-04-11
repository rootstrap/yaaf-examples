module Api
  module V1
    class InvitesController < ApiController
      def create
        @form = Api::V1::BulkInvitesForm.new(invites_params: invites_params)

        if @form.save
          render json: {}, status: :created
        else
          render json: {
            errors: Api::V1::ErrorsSerializer.new(@form).serialize
          }, status: :unprocessable_entity
        end
      end

      private

      def invites_params
        params.permit(invites: [:email])
      end
    end
  end
end
