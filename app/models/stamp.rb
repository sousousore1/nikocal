class Stamp < ActiveRecord::Base
  belongs_to :user

  def status_class
    case self.status
    when 1
      'warning'
    when 2
      'danger'
    when 3
      'primary'
    else
      'normal'
    end
  end
end
