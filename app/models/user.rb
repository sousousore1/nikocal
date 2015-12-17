class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name
    if /(.*)@.*/ =~ self.email
      $1
    else
      self.email
    end
  end

  def get_status(target_day)
    statu
  end
end
