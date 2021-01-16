class Source < ApplicationRecord
  validates :original_url, presence: true
  validates :shortened_url, presence: true
end
