# == Schema Information
#
# Table name: boards
#
#  id            :integer          not null, primary key
#  artwork       :boolean
#  condition     :integer
#  construction  :integer
#  fin_config    :integer
#  fin_system    :integer
#  image         :string
#  length        :integer
#  liters        :float
#  notes         :text
#  owner_is_shop :boolean
#  price         :float
#  tail          :integer
#  thickness     :integer
#  width         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  individual_id :integer
#  model_id      :integer
#  shop_id       :integer
#
class Board < ApplicationRecord

  belongs_to(:model, {
    :class_name => "Model",
    :foreign_key => "model_id"
  })

  has_one(:make, {
    :through => :model
  })

  def owner 
    if self.owner_is_shop 
      return Shop.where({:id => self.shop_id}).first
    else 
      return User.where(:id => self.individual_id).first
    end
  end
  
  def tail_str
    if self.tail == 0
      return "Squash"
    elsif self.tail == 1
      return "Square"
    elsif self.tail == 2
      return "Round"
    elsif self.tail == 3
      return "Pin"
    elsif self.tail == 4
      return "Swallow"
    elsif self.tail == 5
      return "Bat"
    elsif self.tail == 6
      return "Diamond"
    end
  end

  def construction_str
    if self.construction == 0
      return "PU"
    elsif self.construction == 1
      return "EPS"
    elsif self.contsruction == 2
      return "Wood"
    elsif self.construction == 3
      return "Other"
    end
  end

  def fin_system_str
    if self.fin_system == 0
      return "FCS"
    elsif self.fin_system == 1
      return "Futures"
    elsif self.fin_system == 2
      return "Glass-on"
    elsif self.fin_system == 3
      return "Other"
    end
  end

  def fin_config_str
    if self.fin_config == 0
      return "3 fin"
    elsif self.fin_config == 1
      return "5 fin"
    elsif self.fin_config == 2
      return "Twin"
    elsif self.fin_config == 3
      return "Single Fin"
    elsif self.fin_config == 4
      return "2+1"
    elsif self.fin_config == 5
      return "Asymmetric"
    elsif self.fin_config == 6
      return "Other"
    end
  end

  def condition_str
    if self.condition == 0
      return "Damaged"
    elsif self.condition == 1
      return "Used"
    elsif self.condition == 2
      return "Like New"
    elsif self.condition == 3
      return "New"
    end
  end

  def length_str
    feet = (self.length / 12).floor
    inches = self.length % 12
    return feet.to_s + "'" + inches.to_s + '"';
  end

  def convert_sixteen(sixteen)
    if sixteen == 0
      return ""
    elsif sixteen == 2
      return "1/8"
    elsif sixteen == 4
      return "1/4"
    elsif sixteen == 6
      return "3/8"
    elsif sixteen == 8
      return "1/2"
    elsif sixteen == 10
      return "5/8"
    elsif sixteen == 12
      return "3/4"
    elsif sixteen == 14
      return "7/8"
    else
      return sixteen.to_s + "/16"
    end
  end

  def width_str
    inches = (self.width / 16).floor
    sixteen = self.width % 16
    sixteen_str = self.convert_sixteen(sixteen)
    if sixteen_str == ""
      return inches.to_s
    else
      return inches.to_s + " " + sixteen_str
    end
  end

  def thickness_str
    inches = (self.thickness / 16).floor
    sixteen = self.thickness % 16
    sixteen_str = self.convert_sixteen(sixteen)
    if sixteen_str == ""
      return inches.to_s
    else
      return inches.to_s + " " + sixteen_str
    end
  end

end
