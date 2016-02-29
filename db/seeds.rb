Education.create!([
  {start_date: "2015-03-12", end_date: "2015-03-15", degree: "IS", university_name: "FSU", student_id: 3},
  {start_date: "2015-03-11", end_date: "2015-03-15", degree: "BA", university_name: "MIT", student_id: 2},
  {start_date: "2015-03-13", end_date: "2015-03-15", degree: "BS ", university_name: "Princeton", student_id: 1},
  {start_date: "2015-03-13", end_date: "2015-03-15", degree: "PHD", university_name: "Havard", student_id: 4}
])
EducationDetail.create!([
  {detail: "Sold grilled cheeses on the great lawn\n", education_id: 2},
  {detail: "Cheated on SAT's", education_id: 4},
  {detail: "Drank a lot of beer!", education_id: nil}
])
Experience.create!([
  {start_date: "2011-04-14", end_date: "2011-05-15", job_title: "admin", company_name: "FB", student_id: 1},
  {start_date: "2015-03-11", end_date: "2015-03-15", job_title: "secretary", company_name: "AOL", student_id: 2}
])
ExperienceDetail.create!([
  {detail: "Worked with . . . .", experience_id: 2},
  {detail: "Ran Spelling Bee", experience_id: 1}
])
Skill.create!([
  {skill_name: "Hacker", student_id: 1},
  {skill_name: "Developer", student_id: 2},
  {skill_name: "Programming", student_id: 3},
  {skill_name: "Waitor", student_id: 4}
])
Student.create!([
  {first_name: "Brent", last_name: "Morris", email: "inkrypto@gmail.com", phone_number: "99999999", linkedin: nil, twitter: nil, blog: nil, online_resume: "yes", github: "github", photo: nil, short_bio: nil},
  {first_name: "Sholmo", last_name: "Twerski", email: "sholmo@acltc.com", phone_number: "768787878", linkedin: "", twitter: nil, blog: nil, online_resume: "yes", github: "github.com", photo: nil, short_bio: nil},
  {first_name: "Jeff", last_name: "Carpenter", email: "jeff@gmail.com", phone_number: "787879789", linkedin: nil, twitter: nil, blog: nil, online_resume: "yes", github: "github/jeff", photo: nil, short_bio: nil},
  {first_name: "Brian", last_name: "Vogelman", email: "brian@gmeila.com", phone_number: "67678997", linkedin: nil, twitter: nil, blog: nil, online_resume: "yes", github: "git", photo: nil, short_bio: nil},
  {first_name: "Troy", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Alex D", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "German", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Mark", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Ryan", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Raquel", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Eugene", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil},
  {first_name: "Alex C", last_name: nil, email: nil, phone_number: nil, linkedin: nil, twitter: nil, blog: nil, online_resume: nil, github: nil, photo: nil, short_bio: nil}
])
