module Api
  module V1
    class GeolocationController < ApplicationController
      rescue_from ActionController::ParameterMissing, :with => :parameter_not_found

      def index
        @geocoder = GeocoderResolver.new query_name: geocoder_params

        if @geocoder.get_coordinates.nil?
          head :not_found
        else
          render json: @geocoder.get_coordinates, status: :ok
        end
      end

      private

      def geocoder_params
        params.require(:geocoder_resolver).require(:query_name)
      end

      def parameter_not_found(error)
        render :json => {:error => error.message}, :status => :not_found
      end

    end
  end
end