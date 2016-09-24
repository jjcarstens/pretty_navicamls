class Listing < ActiveRecord::Base
  geocoded_by :address

  ##
  # Validations
  #
  validates :mls_number, :presence => true

  ##
  # Callbacks
  #
  after_validation :geocode, :if => :address_changed?
  after_create :constructor

  enum :status => {
    :created => 0,
    :queued => 1,
    :toured => 2,
    :not_interested => 3,
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
      "http://maps.google.com/mapfiles/ms/icons/green.png"
    when "queued"
      "http://maps.google.com/mapfiles/ms/icons/yellow.png"
    when "toured"
      "http://maps.google.com/mapfiles/ms/icons/blue.png"
    when "not_interested"
      "http://maps.google.com/mapfiles/ms/icons/red.png"
    end
  end
end
