class Section < ApplicationRecord
  belongs_to :course
  has_many :lessons

  include RankedModel

  belongs_to :course
  ranks :row_order, with_same: :course_id

  validates :title, presence: true, length: { maximum: 140, minimum: 3 }

  def next_section
    section = course.sections.where("row_order > ?", self.row_order).rank(:row_order).first
    return section
  end


end
