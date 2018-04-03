class Place < ApplicationRecord
	has_many :events
	validates :name, length: { minimum: 20 }
	validates :capacity, numericality: { greater_than: 0 }
end
