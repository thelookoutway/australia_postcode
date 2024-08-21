require "australia/postcode/version"
require "csv"

# A module for all things Australian
module Australia
  # The Australia::Postcode class represents Australian postcodes and provides
  # methods for manipulating them. Right now you can find the distance between
  # two postcodes and that's about it.
  class Postcode
    DELIVERY_AREA = "Delivery Area".freeze

    attr_reader :postcode, :suburb, :state, :delivery_center, :type, :latitude, :longitude

    def initialize(postcode, suburb, state, delivery_center, type, latitude, longitude)
      @postcode = postcode.to_i
      @suburb = suburb.strip
      @state = state.strip
      @delivery_center = delivery_center.strip
      @type = type.strip
      @latitude = latitude.to_f
      @longitude = longitude.to_f
    end

    # Returns a [latitude, longitude] tuple
    #
    # @return [Array]
    def coords
      [latitude, longitude]
    end

    # Computes the distance from this postcode to another postcode using the
    # Haversine formula
    #
    # @return [Float]
    def distance(other)
      earth_radius = 6371
      delta_lat = radians(other.latitude - latitude)
      delta_lon = radians(other.longitude - longitude)
      a = sin(delta_lat / 2) * sin(delta_lat / 2) +
        cos(radians(latitude)) * cos(radians(other.latitude)) *
        sin(delta_lon / 2) * sin(delta_lon / 2)
      c = 2 * atan2(sqrt(a), sqrt(1 - a))
      earth_radius * c
    end
    alias_method :-, :distance

    def nearby(distance:)
      self.class.all.select do |other|
        distance(other) <= distance
      end
    end

    # Inspects the [Postcode]
    def inspect
      "#<#{self.class} postcode=#{postcode.inspect} suburb=#{suburb.inspect} latitude=#{latitude.inspect} longitude=#{longitude.inspect}>"
    end

    private

    include Math

    def radians(degrees)
      degrees * PI / 180
    end

    class << self
      # Finds all postcodes/suburbs for the given postcode.
      #
      # @return [Array[Postcode]]
      def find(postcode)
        indexed_on_postcode[postcode.to_i]
      end

      # Finds all the postcodes/suburbs for the given suburb name.
      #
      # @return [Array[Postcode]]
      def find_by_suburb(suburb)
        indexed_on_suburb[suburb.strip.upcase]
      end

      # Finds the closest postcode to the given coordinates
      #
      # @return [Postcode]
      def find_by_coords(latitude, longitude)
        data.min_by { |postcode|
          (latitude - postcode.latitude) ** 2 + (longitude - postcode.longitude) ** 2
        }
      end

      # @return [Array<Australia::Postcode>]
      def all
        data
      end

      private

      def indexed_on_postcode
        @indexed_on_postcode ||= data.group_by(&:postcode)
      end

      def indexed_on_suburb
        @indexed_on_suburb ||= data.group_by(&:suburb)
      end

      # @return [Array<Australia::Postcode>]
      def data
        @data ||= CSV
          .table(data_filename)
          .each_with_object([]) do |row, acc|
            next unless row[:type].start_with?(DELIVERY_AREA)

            acc.push(new(*row.fields(
              :postcode,
              :suburb,
              :state,
              :dc,
              :type,
              :lat,
              :lon,
            )))
          end
      end

      def data_filename
        File.expand_path("../postcode/data.csv", __FILE__)
      end
    end
  end
end
