require 'nokogiri'

module PrettyNavicamls
  class Parser
    ##
    # Class methods
    #
    def self.parse_listings(page)
      parser = self.new(page)
      parser.parse_and_create_listings
    end

    ##
    # Instance methods
    #
    attr_reader :doc

    def initialize(page)
      @doc = ::Nokogiri::HTML.parse(page)
    end

    def parse_and_create_listings
      listings = doc.css("div[align=center]").select do |div|
        div if has_mls_number?(div) && has_details_container?(div)
      end

      listings.each do |listing_html|
        parsed_listing = ::PrettyNavicamls::ListingBuilder.new(listing_html)
        listing = ::Listing.by_mls_number(parsed_listing.mls_number).first_or_create
        listing.update_attributes(
          :address => parsed_listing.address,
          :list_price => parsed_listing.list_price,
          :picture_url => parsed_listing.picture_url
        )
      end
    end

  private

    def has_details_container?(element)
      element.css("#expanded-container").present?
    end

    def has_mls_number?(element)
      element.css("input[name=mlsn_list]").present?
    end
  end
end
