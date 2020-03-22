class Location < ApplicationRecord
  validates :latitude, :longtitude, :display_name, presence: true
  validates :latitude, :longtitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
  validates :display_name, uniqueness: true

  scope :search_by_keywords, lambda { |keywords|
    where(
      keywords.size.times.map { '(display_name ILIKE ?)' }.join(' AND '),
      *keywords.map { |keyword| "%#{keyword}%" }
    )
  }
end
