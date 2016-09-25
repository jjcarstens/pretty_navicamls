require 'open-uri'

class ListingsController < ::ApplicationController
  before_action :find_listing, :only => [:show]
  def index
    @listings = ::Listing.all
    @listings_map_hash = generate_listings_map_hash
  end

  def create
    fail ::PrettyNavicamls::Error::UnsupportedURL unless supported_url?
    ::PrettyNavicamls::Parser.parse_listings(navicamls_listings_url)
    flash[:notice] = "Successfully added homes from #{navicamls_listings_url}"
    redirect_to "/"
  rescue ::PrettyNavicamls::Error::UnsupportedURL => e
    flash[:error] = "#{e.message}: #{navicamls_listings_url}"
    redirect_to "/"
  end

  def show
    response.headers.delete "X-Frame-Options"
  end

private

  def find_listing
    @listing = ::Listing.by_mls_number(mls_number).first
  end

  def mls_number
    params.require(:id)
  end

  def navicamls_listings_url
    params.require(:navicamls_url)
  end

  def generate_listings_map_hash
    ::Gmaps4rails.build_markers(@listings) do |listing, marker|
      marker.lat(listing.latitude)
      marker.lng(listing.longitude)
      marker.picture({
        :url    => listing.pin_url,
        :width  => "64",
        :height => "64",
        :scaledWidth => "32", # Scaled width is half of the retina resolution; optional
        :scaledHeight => "32", # Scaled width is half of the retina resolution; optional
      })
      marker.title("#{listing.mls_number} | #{listing.address}")
      marker.infowindow render_to_string(:partial => "infowindow.html.erb", :locals => { :listing => listing}).gsub(/\n/, '')
    end
  end

  def supported_url?
    navicamls_listings_url.include?("navicamls")
  end
end
