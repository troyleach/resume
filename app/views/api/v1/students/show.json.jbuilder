json.personal_information @student
json.id @student.id
json.first_name @student.first_name
json.last_name @student.last_name
json.email @student.email
json.phone_number @student.phone_number
json.linkedin @student.linkedin
json.twitter @student.twitter
json.blog @student.blog
json.online_resume @student.online_resume
json.github @student.github
json.address @student.address
json.appt_number @student.appt_number
json.city @student.city
json.state @student.state
json.photo @student.photo
json.short_bio @student.short_bio
json.job_title @student.job_title

json.professional_skills @student.professional_skills do |professional_skill| 
  json.id professional_skill.id
  json.student_id professional_skill.student_id
  json.skill_name professional_skill.skill_name
end

json.personal_skills @student.personal_skills do |personal_skill|
  json.id personal_skill.id
  json.student_id personal_skill.student_id
  json.skill_name personal_skill.skill_name
end

json.educations @student.educations do |education|
	json.id education.id
  json.degree education.degree
  json.university_name education.university_name
  json.start_date education.start_date
  json.end_date education.end_date
  json.student_id education.student_id
  json.present education.present
  json.details education.education_details do |education_detail|
    json.id education_detail.id
    json.detail education_detail.detail
    json.education_id education_detail.education_id
  end
end


json.experiences @student.experiences do |experience|
	json.id experience.id
  json.job_title experience.job_title 
  json.company_name experience.company_name
  json.start_date experience.start_date 
  json.end_date experience.end_date
  json.job_description experience.job_description
  json.student_id experience.student_id
  json.present experience.present
  json.details experience.experience_details do |experience_detail|
    json.id experience_detail.id
    json.detail experience_detail.detail
    json.experience_id experience_detail.experience_id
  end
end

json.references @student.references do |reference|
json.id reference.id
json.student_id reference.student_id
json.first_name reference.first_name
json.last_name reference.last_name
json.email reference.email
json.phone_number reference.phone_number
json.company_name reference.company_name
end