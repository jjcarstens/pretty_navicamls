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

  ##
  # Scopes
  #
  scope :by_mls_number, lambda { |*mls_numbers| where(:mls_number => mls_numbers.compact.uniq) }
end
