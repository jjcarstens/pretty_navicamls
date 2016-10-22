require 'open-uri'

class ListingsController < ::ApplicationController
  before_action :find_listing, :only => [:show, :update_status]
  def index
    @listings = ::Listing.all
    @listings_map_hash = generate_listings_map_hash
  end

  def create
    fail ::PrettyNavicamls::Error::UnsupportedURL unless supported_url?

    parser_results = ::PrettyNavicamls::Parser.parse_listings(navicamls_listings_url)
    flash[:notice] = "Successfully added #{parser_results[:successful]} homes from #{navicamls_listings_url}"

    if parser_results[:invalid_attributes].present?
      flash[:warning] = "Invalid Attributes found: #{parser_results[:invalid_attributes]}"
    end

    redirect_to "/"
  rescue ::PrettyNavicamls::Error::UnsupportedURL => e
    flash[:error] = "#{e.message}: #{navicamls_listings_url}"
    redirect_to "/"
  end

  def show
  end

  def update_status
    @listing.update_attributes(:status => status_param)
    flash[:ok] = "Status updated: #{status_param}"
    redirect_to :back
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
    ::Listing.statuses.each_with_object({}) do |(status, enum), hash|
      listings_for_status = ::Listing.by_status(status)

      hash[status.titleize] = ::Gmaps4rails.build_markers(listings_for_status) do |listing, marker|
        status_color = ::Listing::PIN_COLORS_FROM_STATUS[listing.status]
        marker.lat(listing.latitude)
        marker.lng(listing.longitude)
        marker.picture({
          :url    => listing.pin_url,
          :width  => "64",
          :height => "64",
          :scaledWidth => "32", # Scaled width is half of the retina resolution; optional
          :scaledHeight => "32", # Scaled width is half of the retina resolution; optional
        })
        marker.title("[ <span style='color:#{status_color}'>#{listing.mls_number}</span> ] #{listing.address}")
        marker.infowindow render_to_string(:partial => "infowindow.html.erb", :locals => { :listing => listing}).gsub(/\n/, '')
      end
    end
  end

  def status_param
    params.require(:status)
  end

  def supported_url?
    navicamls_listings_url.include?("navicamls")
  end
end
