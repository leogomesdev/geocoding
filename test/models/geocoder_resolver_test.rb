require 'test_helper'

class GeocoderResolverTest < ActiveSupport::TestCase

  test "should return nil coordinates when without query_name param" do
    geocoderResolver = GeocoderResolver.new
    assert_nil geocoderResolver.get_coordinates
  end

  test "should return the an value for a valid query_name" do
    geocoderResolver = GeocoderResolver.new(query_name: 'Francisco Muratori Street')
    assert_not_empty geocoderResolver.get_coordinates
  end

  test "should return the correct value for query_name checkpoint charlie" do
    geocoderResolver = GeocoderResolver.new(query_name: 'checkpoint charlie')
    result = geocoderResolver.get_coordinates
    expected = [
        52.5074434,
        13.3903913
    ]
    assert_equal(expected, result)
  end

end
