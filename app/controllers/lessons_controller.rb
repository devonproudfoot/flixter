class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_lesson_view, only: [:show]

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_enrollment_for_lesson_view
    unless current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: 'You must register for the course to view the lessons!'
    end
  end
end
