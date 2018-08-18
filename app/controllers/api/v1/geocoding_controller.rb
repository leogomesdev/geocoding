module Api
  module V1
    class GeocodingController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      rescue_from ActionController::ParameterMissing, :with => :parameter_not_found
      before_action :authenticate, only: [:index]

      def index
        @geocoder = GeocoderResolver.new query_name: geocoder_params

        if @geocoder.get_coordinates.nil?
          render json: {"error": "this address is invalid"}, status: :not_found
        else
          render json: @geocoder.get_coordinates, status: :ok
        end
      end

      private

      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          @user = User.find_by(token: token)
        end
      end

      def geocoder_params
        params.require(:query_name)
      end

      def parameter_not_found(error)
        render :json => {:error => error.message}, :status => :not_found
      end

    end
  end
end