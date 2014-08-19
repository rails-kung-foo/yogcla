require 'trimmer'
class Admin < ActiveRecord::Base
  # Gatekeeper, man the door!
  include Trimmer
 
  trimmed_fields :name, :admin_password, :admin_password_confirmation
	
	# name
  validates :name, presence: true, uniqueness: true,length: { maximum: 50 }
	
	
	# validates password
	VALID_PW_REGX = /(?=.*[a-zA-Z])(?=.*[\d])(?=.*[\W]).{6,20}/
	validates :password, format:{ with: VALID_PW_REGX },
		 length: { minimum: 6, maximum: 20 }
  has_secure_password
 
 
 
 
 end
