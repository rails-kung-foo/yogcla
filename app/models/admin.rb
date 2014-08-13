require 'trimmer'
class Admin < ActiveRecord::Base
  # Gatekeeper, man the door!
  include Trimmer
 
  trimmed_fields
  validates :name, presence: true, uniqueness: true
  has_secure_password
 
 
 
 
 end
