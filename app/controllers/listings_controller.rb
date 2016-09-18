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
      marker.picture({
        :url    => "http://maps.google.com/mapfiles/ms/icons/green-dot.png",
        :width  => "64",
        :height => "64",
        :scaledWidth => "32", # Scaled width is half of the retina resolution; optional
        :scaledHeight => "32", # Scaled width is half of the retina resolution; optional
      })
      marker.title("#{listing.mls_number} | #{listing.address}")
      marker.infowindow render_to_string(:partial => "infowindow.html.erb", :locals => { :listing => listing}).gsub(/\n/, '')
      # marker.infowindow("#{listing.mls_number}
      # #{listing.address}
      # #{listing.list_price}
      # <img border=\"0\" id=\"photo-2100961\" class=\"photo-expanded\" height=\"165\" width=\"220\" src=\"http://www.navicamls.net/displays/getPhoto.asp?E439Z9=%B5%80%9A%C2%C4%5C%C5%AA%AC%B7%A2%8B%9E%B1%B6%8A%B8%A3%C4%86%8A%5Bu%B8%A4%A2%C6%BD%AB%BB%A1v%ACyX%89ev%5Fj%9En%82%A0%C3%99&amp;n=359\"></img>")
    end
  end

  def supported_url?
    navicamls_listings_url.include?("navicamls")
  end
end
