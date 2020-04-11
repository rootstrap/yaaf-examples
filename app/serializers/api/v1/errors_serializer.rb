module Api
  module V1
    class ErrorsSerializer
      attr_reader :object

      def initialize(object)
        @object = object
      end

      def serialize
        object.errors.to_h.map { |message| { detail: message } }
      end
    end
  end
end
