class Style < ActiveRecord::Base
	include Trimmer

	has_many :courses, dependent: :destroy
	before_create :downcase_field

	trimmed_fields :stil
	validates :stil, presence: true

	scope :by_stil, -> (stil){ where('stil = ?', stil) }

	# case down
	def downcase_field
      self.stil.downcase!
    end

	# caching
	def self.latest
		order(:updated_at).last
	end
end
