require 'trimmer'
class Style < ActiveRecord::Base
	# Gatekeeper, man the door!
	has_many :courses, dependent: :destroy	
	before_create :downcase_field
	
	include Trimmer
	
	trimmed_fields :stil
	validates :stil, presence: true
	
  private
	# case down 
	def downcase_field
      self.stil.downcase!
    end
	# caching 
	def self.latest
		Style.order(:updated_at).last
	end
end
