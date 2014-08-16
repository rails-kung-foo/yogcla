require 'trimmer'
require 'formHelper'
class Course < ActiveRecord::Base
	# Gatekeeper, man the door!
  belongs_to :studio
  belongs_to :style
  
	include Trimmer
	trimmed_fields :start, :end
	validates :start, :end, presence: true
  

	
	
	
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
	# set name
	def self.set_name(course_id)
		find_by(id: course_id).name
	end
	
end
