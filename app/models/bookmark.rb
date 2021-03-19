# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  user_id    :integer
#
class Bookmark < ApplicationRecord

  belongs_to(:board, {
    :class_name => "Board",
    :foreign_key => "board_id"
  })
end
