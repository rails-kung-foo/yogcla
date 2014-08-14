require 'trimmer'
class Course < ActiveRecord::Base
	# Gatekeeper, man the door!
  belongs_to :studio
  belongs_to :style
  
  	include Trimmer
	trimmed_fields :start, :end
	validates :start, :end, presence: true
  
	# Data for select field
	WEEKDAYS = [
		"sunday",
		"monday",
		"tuesday",
		"wednesday",
		"thursday",
		"friday",
		"saturday"
	]
	
	# Set ready for select field. Get data from db!
	GETSTUDIOS = Studio.all.collect(&:name)
	GETSTYLES = Style.all.collect(&:stil)
	
	
	
	# Style.all.each do |x|
		# GETSTYLES << x.stil
	# end
	
	# Studio.all.each do |x|
		# GETSTUDIOS << x.name
	# end
  
  
  	# caching 
	def self.latest
		Course.order(:updated_at).last
	end
end
