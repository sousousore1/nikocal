class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :stamps, dependent: :destroy

  def name
    if /(.*)@.*/ =~ self.email
      $1
    else
      self.email
    end
  end

  def find_stamp_by(target_date)
    stamps = self.stamps.find_all do |x| x.target_date == target_date end
    stamps.first
  end
end
