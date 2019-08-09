class ChangeEnrollmentsColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :enrollments, :user_id, 'integer USING CAST(user_id AS integer)'
    change_column :enrollments, :course_id, 'integer USING CAST(course_id AS integer)'
  end
end
