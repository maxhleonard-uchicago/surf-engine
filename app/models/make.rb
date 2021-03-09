# == Schema Information
#
# Table name: makes
#
#  id         :integer          not null, primary key
#  logo       :string
#  name       :string
#  webpage    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Make < ApplicationRecord

  has_many(:models, {
    :class_name => "Model",
    :foreign_key => "make_id"
  })
end
