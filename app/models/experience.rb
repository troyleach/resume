class Experience < ActiveRecord::Base
	belongs_to :student
	has_many :experience_details
end
