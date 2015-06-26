class Course < ActiveRecord::Base
  include Trimmer

  belongs_to :studio
  belongs_to :style

	trimmed_fields :start, :ending

	# Validate time to bbe HH:MM
	VALID_TIME = /([0-1][0-9]||[2][0-3]):[0-5][0-9]/
	validates :start, :ending, presence: true, format:{ with: VALID_TIME },
		 length:{ is: 5 }
  validates :studio_id, :style_id, :weekday, presence: true
  validates :weekday, inclusion: { in: ApplicationHelper::WEEKDAYS }

  scope :by_weekday, -> (day){ where('weekday = ?', day) }

  # search logicCourse
	def self.filter_by options = {}
    result = all

    unless options[:day].blank? || options[:day] == 'Select All'
      result = result.by_weekday options[:day]
		end

    unless options[:style].blank? || options[:style] == 'Select All'
      result = result.joins(:style).merge(Style.by_stil(options[:style]))
		end

    unless options[:studio].blank? || options[:studio] == 'Select All'
      result = result.joins(:studio).merge(Studio.by_name(options[:studio]))
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

end
