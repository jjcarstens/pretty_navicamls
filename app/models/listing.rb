class Listing < ActiveRecord::Base
  geocoded_by :address
  has_attached_file :cover_photo, :styles => { :thumb => "165x220>" }, :validate_media_type => false

  MARKER_URL = "http://maps.google.com/mapfiles/ms/icons/".freeze

  ##
  # Validations
  #
  # # Validate content type
  validates_attachment_content_type :cover_photo, content_type: /\Aimage/
  validates :mls_number, :presence => true

  ##
  # Callbacks
  #
  after_validation :geocode, :if => :address_changed?
  after_validation :set_price_change, :if => :list_price_changed?
  before_create :constructor

  PIN_COLORS_FROM_STATUS = {
    "created" => "green",
    "queued" => "yellow",
    "toured" => "blue",
    "not_interested" => "red",
    "price_change" => "purple"
  }

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

  def cover_photo_remote_url=(url_value)
    self.cover_photo = URI.parse(url_value)
    super
  end

  def pin_url
    return "https://www.emojibase.com/resources/img/emojis/apple/x1f389.png.pagespeed.ic.FkjckyE3hU.png" if favorite?
    color = PIN_COLORS_FROM_STATUS[status]
    "#{MARKER_URL}#{color}.png"
  end

private

  def set_price_change
    return if list_price.blank? || list_price_was.blank?
    self.status = ::Listing.statuses[:price_change]
    self.list_price_change_amount = list_price - list_price_was
  end
end
