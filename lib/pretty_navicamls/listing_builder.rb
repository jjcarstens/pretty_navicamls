module PrettyNavicamls
  class ListingBuilder
    attr_reader :listing_html, :navica_url

    def initialize(html, url)
      @listing_html = html
      @navica_url = url
    end

    def attributes
      sale_attributes.merge(property_attributes)
    end

    def mls_number
      @mls_number ||= listing_html.at("input[name=mlsn_list]")["value"].to_i
    end

    def property_attributes
      listing_html.css("#expanded-label").each_with_object({}) do |element, hash|
        attribute = element.text.parameterize.underscore
        value = element.next.text.split(/\r?\n/).last

        hash[attribute.to_sym] = value
      end
    end

    def sale_attributes
      {
        :address => address,
        :list_price => list_price,
        :navica_url => navica_url,
        :picture_url => picture_url
      }
    end

  private

    def address
      @address ||= listing_html.at("#expanded-address-label").text
    end

    def list_price
      @list_price ||= begin
        # Just a few <strong> with text not easily targeted so we split out
        # all the whitespace to grab the last item which will be list_price
        mls_labels = listing_html.at("#expanded-mls-label").text.split

        # Strip out any $ or , characters then convert to integer
        mls_labels.last.gsub(/[^0-9.]/, "").to_i
      end
    end

    def picture_url
      @picture_url ||= begin
        pic_path = listing_html.at("img[class=photo-expanded]")["src"]
        "http://www.navicamls.net/displays/#{pic_path}"
      end
    end
  end
end
