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

  scope :by_weekday, -> (day){ where('weekday = ?', day) }


  # search logicCourse
	def self.search_by day = nil, style = nil, studio = nil
    result = all

    unless day.blank? || day == 'Select All'
      result = result.by_weekday day
		end

    unless style.blank? || style == 'Select All'
      result = result.joins(:style).merge(Style.by_stil(style))
		end

    unless studio.blank? || studio == 'Select All'
      result = result.joins(:studio).merge(Studio.by_name(studio))
		end

    result
	end

  # caching
	def self.latest
		order(:updated_at).last
	end

	# set name
	def self.set_name(course_id)
		find_by(id: course_id).name
	end

end
