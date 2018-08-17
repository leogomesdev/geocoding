module Api
  module V1
    class GeolocationController < ApplicationController
      def index
        @a = {}
        render json: @a
      end
    end
  end
end