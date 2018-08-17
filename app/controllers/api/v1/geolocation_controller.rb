module Api
  module V1
    class GeolocationController < ApplicationController
      def index
        @a = Geocoder.search(geolocation_params)
        
        render json: @a.first.coordinates, status: :ok
      end

      def geolocation_params
        params.require(:name)
      end

    end
  end
end