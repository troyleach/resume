class Education < ActiveRecord::Base
	belongs_to :student
	has_many :education_details
end
