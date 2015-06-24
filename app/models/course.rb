class Course < ActiveRecord::Base
  include Trimmer

  belongs_to :studio
  belongs_to :style

	trimmed_fields :start, :ending

	# Validate time to bbe HH:MM
	VALID_TIME = /([0-1][0-9]||[2][0-3]):[0-5][0-9]/
	validates :start, :ending, presence: true, format:{ with: VALID_TIME },
		 length:{ is: 5 }

  scope :by_weekday, -> (day){ where('weekday = ?', day) }


  # search logicCourse
	def self.filter_by day = nil, style = nil, studio = nil
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

  def studio_name
    studio.name
  end

  def style_name
    style.stil
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
