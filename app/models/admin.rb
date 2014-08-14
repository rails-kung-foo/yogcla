require 'trimmer'
class Admin < ActiveRecord::Base
  # Gatekeeper, man the door!
  include Trimmer
 
  trimmed_fields :name, :admin_password, :admin_password_confirmation
  validates :name, presence: true, uniqueness: true
  has_secure_password
 
 
 
 
 end
