require 'trimmer'
# require 'formHelper'
class Course < ActiveRecord::Base
	# Gatekeeper, man the door!
  belongs_to :studio
  belongs_to :style
  
	include Trimmer
	trimmed_fields :start, :end
	
	# Validate time to bbe HH:MM
	VALID_TIME = /(\d){2}[:](\d){2}/
	validates :start, :end, presence: true, format:{ with: VALID_TIME },
		 length:{ is: 5 }	
	
	# -- CODE MOVED TO lib/formHelper.rb
	# Style.all.each do |x|
		# GETSTYLES << x.stil
	# end
	# Studio.all.each do |x|
		# GETSTUDIOS << x.name
	# end
   
	# search logic
	def self.search_courses(weekday) 
		if weekday
			if weekday !=  "Select All" 
				where(weekday: weekday )
			else
				all
			end
		else
			all
		end	
	end
	
	
  # caching 
	def self.latest
		Course.order(:updated_at).last
	end
	# set name
	def self.set_name(course_id)
		find_by(id: course_id).name
	end
	
end
