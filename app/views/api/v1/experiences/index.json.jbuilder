json.experiences @experiences.each do |experience|
	json.id experience.id
	json.start_date experience.start_date
	json.end_date experience.end_date
	json.job_title experience.job_title
	json.company_name experience.company_name
  json.job_description experience.job_description
end