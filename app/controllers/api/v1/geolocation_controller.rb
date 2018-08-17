module Api
  module V1
    class GeolocationController < ApplicationController
      def index
        @a = Geocoder.search("Paris")
        
        render json: @a.first.data
      end
    end
  end
end