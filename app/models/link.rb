class Link < ActiveRecord::Base
  validates :long_link, length: {minimum: 1}
  validates :short_link, length: {minimum: 1}
  validates :long_link, uniqueness: true
  validates :short_link, uniqueness: true
  has_and_belongs_to_many :users

  def self.generate_encoded_string
    encoding_array = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    encoded_link = (0..9).map { encoding_array[rand(encoding_array.length)] }.join
  end
end
