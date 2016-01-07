class Stamp < ActiveRecord::Base
  belongs_to :user

  def status_text
      case self.status
      when 1 then 'いい感じ'
      when 2 then 'まぁまぁ'
      when 3 then 'やな感じ'
      end
  end
end
