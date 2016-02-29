require "prawn/measurement_extensions"
require 'prawn/table'

class WalshPdf < Prawn::Document

  def initialize(student)
    super(:left_margin => 40, :right_margin => 40)
    @student = student
    header
    education
    skills
    experience
    references
    footer_two
    #binding.pry
    # p @student.experiences
    # binding.pry
  end
 
  def header
    # stroke_axis
    self.line_width = 1
    text "#{@student.full_name}", size: 30, style: :bold, color: "17A396" 

    header_data = [
      ["#{@student.email}", {:content => "#{@student.phone_number}", :align => :center }, {:content => "#{@student.blog}", :align => :right }]
    ]

    table(header_data, :width => 530, :cell_style => { :padding => [0, 0, 0, 3], :borders => [], :size => 12, :text_color => "17A396", :font_style => :bold })
  
    stroke_color "#A7C8DB"
    stroke_horizontal_rule 

    canvas do
      bounding_box [bounds.left, bounds.bottom + 25], :width  => bounds.width do
        cell :content => "#{@student.email}",
             :background_color => '17A396',
             :width => bounds.width,
             :height => 25,
             :align => :center,
             :text_color => "FFFFFF",
             :borders => [],
             :border_width => 2,
             :border_color => 'FF0000',
             :padding => 5
      end
    end

  end # end of header

  # the below code is hack. there is bug in prawns gem with column widths with nested tables. I will submit an issue 6-16-2015. The code is located in the issues.rb file in this same directory  
  def education
    rotate(90, :origin => [-167, 268]) { 
        font_size 12
        fill_color "17A396"
        transparent(0.2) { fill_rectangle [100, 100], 120, 14 }
        text_box "EDUCATION", :at => [100, 97.5], :width => 120, :align => :center
      }

    font_size 10
    bounding_box([15, 680], :width => 400) do
      pad_top(25) {
        @student.educations.each do |education|
          
        table([ ["#{convert_to_year(education.start_date, education.end_date, education.present)}", {:content => "#{education['degree']}", :font_style => :bold, :text_color => "17A396" } ],
                ["", {:content => "#{education["university_name"]}", :font_style => :bold }],],
                :cell_style => { :border_lines => [:dotted], :borders => [], :padding => [0, 0, 1, 5] }, :column_widths => {0 => 60})

          table(sub_table(education.education_details), :position => 75, :cell_style => { :border_lines => [:dotted], :borders => [], :padding => [0, 0, 3, 10], :width => 400 })
        move_down 5
        end
      } 
    end # end of education


  def skills
    font_size 10
    rotate(90, :origin => [2, 437]) {
    font_size 12 
        fill_color "17A396"
        transparent(0.2) { fill_rectangle [100, 100], 120, 14 }
        text_box "SKILLS", :at => [100, 97.5], :width => 120, :align => :center
      }
    # gap seems to be the indentation of the body of text
    gap = 30
    bounding_box([360, 680], :width => 140) do
    pad_top(20) {
      font_size 10
      @student.professional_skills.each do |skill|
        pad(5) { text "#{skill["skill_name"]}" }
        stroke_horizontal_rule 
      end
      }      
  end #End skills bounding box

  
    end #End education bounding box
    
    def experience
      
# the below wdith of 480 is correct, that is the width that I would like!
# the below code is hack. there is bug in prawns gem with column widths with nested tables. I will submit an issue 6-16-2015. The code is located in the issues.rb file in this same directory
      # bounding_box([15, 443], :width => 480, :height => 500) do
      span(480, :position => 16) do
        rotate(90, :origin => [163,  -77]) { 
            font_size 12
            fill_color "17A396"
            transparent(0.2) { fill_rectangle [100, 100], 120, 14 }
            text_box "EXPERIENCE", :at => [100, 97.5], :width => 120, :align => :center
          }
        font_size 10
        pad_top(20) {
          @student.experiences.each do |experience|
            table([ ["#{convert_to_year(experience.start_date, experience.end_date, experience.present)}", {:content => "#{experience["job_title"]}", :font_style => :bold, :text_color => "17A396" } ],
                    ["", {:content => "#{experience["company_name"]}", :font_style => :bold }], ["", "#{experience.job_description}", ""]],
                    
                    :cell_style => { :border_lines => [:dotted], :borders => [], :padding => [0, 0, 1, 5] }, :column_widths => [60])

              table(sub_table(experience.experience_details), :position => 75, :cell_style => { :border_lines => [:dotted], :borders => [], :padding => [0, 0, 3, 0], :width => 400 })
            move_down 5
          end
        } 
      end #End bounding box
    end #End experience
    
  end

  def references
    bounding_box [bounds.left, bounds.bottom + 15], :width  => bounds.width do
      data = [["References upon request"]]
      table(data, :position => :center, :cell_style => { :borders => [] } )
    end
  end

def footer_two
  
end


private

  def convert_to_year(start_date, end_date, present)
    if present
      "#{start_date.year} - Present"
    else
      "#{start_date.year} - #{end_date.year}"
    end
  end

  def sub_table(array)
    new_sub_table = []
    if array.size == 0
      new_sub_table << Array.new(1, "")
    else
      array.each do |array_elements|
        new_sub_table << Array.new(1, array_elements["detail"])
      end
    end
    return new_sub_table
  end
end
