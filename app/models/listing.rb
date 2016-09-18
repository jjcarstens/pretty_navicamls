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
  after_initialize :constructor

  enum :status => {
    :created => 0,
    :toured => 1,
    :not_interested => 2,
  }

  ##
  # Scopes
  #
  scope :by_mls_number, lambda { |*mls_numbers| where(:mls_number => mls_numbers.compact.uniq) }

  def constructor
    self.status = ::Listing.statuses[:created]
  end

end
