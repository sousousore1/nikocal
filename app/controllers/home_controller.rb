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

    all_stamps = @users.flat_map do |x|
      x.stamps
    end

    @todays_stamps = all_stamps.find_all do |x|
      x.target_date == @this_day
    end

    @todays_stamps_1 = @todays_stamps.find_all do |x|
      x.status == 1
    end

    @todays_stamps_2 = @todays_stamps.find_all do |x|
      x.status == 2
    end

    @todays_stamps_3 = @todays_stamps.find_all do |x|
      x.status == 3
    end
  end
end
