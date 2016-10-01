class Listing < ActiveRecord::Base
  geocoded_by :address

  MARKER_URL = "http://maps.google.com/mapfiles/ms/icons/".freeze

  ##
  # Validations
  #
  validates :mls_number, :presence => true

  ##
  # Callbacks
  #
  after_validation :geocode, :if => :address_changed?
  after_validation :set_price_change, :if => :list_price_changed?
  before_create :constructor

  enum :status => {
    :created => 0,
    :queued => 1,
    :toured => 2,
    :not_interested => 3,
    :price_change => 4
  }

  ##
  # Scopes
  #
  scope :by_mls_number, lambda { |*mls_numbers| where(:mls_number => mls_numbers.compact.uniq) }

  def constructor
    self.status = ::Listing.statuses[:created]
  end

  def pin_url
    return "https://www.emojibase.com/resources/img/emojis/apple/x1f389.png.pagespeed.ic.FkjckyE3hU.png" if favorite?

    case status
    when "created"
      "#{MARKER_URL}green.png"
    when "queued"
      "#{MARKER_URL}yellow.png"
    when "toured"
      "#{MARKER_URL}blue.png"
    when "not_interested"
      "#{MARKER_URL}red.png"
    when "price_change"
      "#{MARKER_URL}purple.png"
    end
  end

private

  def set_price_change
    self.status = ::Listing.statuses[:price_change]
    self.list_price_change_amount = list_price - list_price_was
  end
end
