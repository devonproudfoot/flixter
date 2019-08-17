class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:create]
  before_action :require_authorized_for_current_section, only: [:update]

  def create
    @section = current_course.sections.create(section_params)
    if @section.invalid?
      flash[:alert] = '<strong>Section not saved! Data is not valid!</strong>'
    else
      flash[:notice] = 'Section created!'
    end
    redirect_to instructor_course_path(current_course)
  end

  def update
    current_section.update_attributes(section_params)
    render plain: 'Updated!'
  end

  private

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find(params[:course_id])
  end

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  def current_section
    @current_section ||= Section.find(params[:id])
  end

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      render plain: 'Unauthorized'
    end
  end

end
