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

      puts listings.count

      listings.each do |listing_html|
        listing = ::PrettyNavicamls::ListingBuilder.new(listing_html)
        ::Listing.by_mls_number(listing.mls_number).first_or_create do |l|
          l.address = listing.address
          l.list_price = listing.list_price
        end
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
