# == Schema Information
#
# Table name: distances
#
#  id          :integer          not null, primary key
#  destination :string
#  distance    :integer
#  duration    :integer
#  origin      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Distance < ApplicationRecord
end
