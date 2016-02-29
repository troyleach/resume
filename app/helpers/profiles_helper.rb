module ProfilesHelper
  def users_name(name)
    name = name.downcase
    @students.each do |fullname|
      user_name = fullname.first_name.downcase + fullname.last_name.downcase
      if user_name == name
        return fullname.id
      else
      end
    end
    return false
  end

  def return_year(date_object)
    if date_object
      date_object.year
    else
      return 'N/A'
    end
  end
end
