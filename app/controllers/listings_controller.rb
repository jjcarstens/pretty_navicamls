require 'open-uri'

class ListingsController < ::ApplicationController
  def index
    @listings = ::Listing.all
    @listings_map_hash = generate_listings_map_hash
  end

  def create
    fail ::PrettyNavicamls::Error::UnsupportedURL unless supported_url?
    page = open(navicamls_listings_url).read
    ::PrettyNavicamls::Parser.parse_listings(page)
    flash[:notice] = "Successfully added homes from #{navicamls_listings_url}"
    redirect_to "/"
  rescue ::PrettyNavicamls::Error::UnsupportedURL => e
    flash[:error] = "#{e.message}: #{navicamls_listings_url}"
    redirect_to "/"
  end

private

  def navicamls_listings_url
    params.require(:navicamls_url)
  end

  def generate_listings_map_hash
    ::Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat(listing.latitude)
      marker.lng(listing.longitude)
      marker.title("#{listing.mls_number} | #{listing.address}")
      marker.infowindow("#{listing.mls_number}
      #{listing.address}
      #{listing.list_price}")
    end
  end

  def supported_url?
    navicamls_listings_url.include?("navicamls")
  end
end
