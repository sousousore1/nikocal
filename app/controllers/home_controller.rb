class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:help]
  def index
    @users = User.all.sort_by do |x|
      if x.stamps.any?
        x.stamps.last.updated_at
      else
        x.created_at
      end
    end.reverse
    @this_day = Date.today
    @this_monday = @this_day - (@this_day.wday - 1)
    @display_days = DISPLAY_DAYS
    @stamp = current_user.stamps.new
  end
end
