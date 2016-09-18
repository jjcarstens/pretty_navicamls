module PrettyNavicamls
  class ListingBuilder
    attr_reader :listing_html

    def initialize(html)
      @listing_html = html
    end

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

    def lot_size

    end

    def mls_number
      @mls_number ||= listing_html.at("input[name=mlsn_list]")["value"].to_i
    end

    def picture_url
      @picture_url ||= begin
        pic_path = listing_html.at("img[class=photo-expanded]")["src"]
        "http://www.navicamls.net/displays/#{pic_path}"
      end
    end
  end
end
