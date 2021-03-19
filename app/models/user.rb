# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  address         :string
#  email           :string
#  employee        :boolean
#  first_name      :string
#  last_name       :string
#  lat             :float
#  lon             :float
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  shop_id         :integer
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password


  has_many(:bookmarks, {
    :class_name => "Bookmark",
    :foreign_key => "user_id"
  })

  def shop
    if self.employee
      return Shop.where({:id => self.shop_id}).first
    else
      return nil
    end
  end
end
