class GeocoderResolver

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :query_name

  validates :query_name, :presence => true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def get_coordinates
    @result = Geocoder.search(self.query_name)
    @result.first.coordinates unless @result.first.nil?
  end

end
