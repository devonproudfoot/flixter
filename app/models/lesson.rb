class Lesson < ApplicationRecord
  belongs_to :section
  mount_uploader :video, VideoUploader

  include RankedModel

  belongs_to :section
  ranks :row_order, :with_same => :section_id
end
