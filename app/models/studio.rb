require 'trimmer'
class Studio < ActiveRecord::Base
	# Gatekeeper, man the door!
	has_many :courses, dependent: :destroy
	
	include Trimmer
	trimmed_fields :name, :address, :url
	
	validates :name, :address, presence: true
	
	# caching 
	def self.latest
		Studio.order(:updated_at).last
	end
	
end
