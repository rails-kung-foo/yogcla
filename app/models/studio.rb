class Studio < ActiveRecord::Base
	include Trimmer

	has_many :courses, dependent: :destroy

	trimmed_fields :name, :address, :url

	validates :name, :address, presence: true

	scope :by_name, -> (name){ where('name = ?', name) }

	# caching
	def self.latest
		Studio.order(:updated_at).last
	end

end
