# == Schema Information
#
# Table name: models
#
#  id         :integer          not null, primary key
#  image      :string
#  name       :string
#  webpage    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  make_id    :integer
#
class Model < ApplicationRecord
end
