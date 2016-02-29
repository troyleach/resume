class ResumesController < ApplicationController

  def index
  end

  def show
    @student = Resume.find(params[:id])
    file = @student.full_name + "-Resume.pdf"

    respond_to do |format|
      format.html
      format.pdf do
        pdf = LeachPdf.new(@student)
        send_data pdf.render, type: 'application/pdf', disposition: "inline"
      end
    end  
  end

  def walsh_template_show
    @student = Resume.find(params[:id])
    file = @student.full_name + "-Resume.pdf"

    respond_to do |format|
      format.html
      format.pdf do
        pdf = WalshPdf.new(@student)
        send_data pdf.render, type: 'application/pdf', disposition: "inline"
      end
    end  
  end

  def leach_template_show
    @student = Resume.find(params[:id])
    #this is ONLY to test a github pull request
    # file = @student.full_name + "-Resume.pdf"
    respond_to do |format|
      format.html
      format.pdf do
        pdf = LeachPdf.new(@student)
        send_data pdf.render, type: 'application/pdf', disposition: "inline"
      end
    end  
  end

  def down_load_pdf
    student = Resume.find(params[:id])
    file = student.full_name + "-Resume.pdf"
    if params["template"] == 'leach'
      respond_to do |format|
        format.html
        format.pdf do
          pdf = LeachPdf.new(student)
          send_data pdf.render, filename: file, type: 'application/pdf'
        end
      end
    else
      respond_to do |format|
        format.html
        format.pdf do
          pdf = WalshPdf.new(student)
          send_data pdf.render, filename: file, type: 'application/pdf'
        end
      end
    end
  end

end
