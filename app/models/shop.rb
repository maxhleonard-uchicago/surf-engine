# == Schema Information
#
# Table name: shops
#
#  id           :integer          not null, primary key
#  address      :string
#  lat          :float
#  logo         :string
#  lon          :float
#  name         :string
#  verification :string
#  website      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Shop < ApplicationRecord
end
