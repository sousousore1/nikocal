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
    @today = Date.today
    @yesterday = @today - (@today.wday == 1 ? 3 : 1)
    @this_monday = @today - (@today.wday - 1)
    @display_days = DISPLAY_DAYS
    @stamp = current_user.stamps.new

    all_stamps = @users.flat_map do |x|
      x.stamps
    end

    @yesterday_stamps = all_stamps.find_all do |x|
      x.target_date == @yesterday
    end

    @yesterday_stamps_1 = @yesterday_stamps.find_all do |x|
      x.status == 1
    end

    @yesterday_stamps_2 = @yesterday_stamps.find_all do |x|
      x.status == 2
    end

    @yesterday_stamps_3 = @yesterday_stamps.find_all do |x|
      x.status == 3
    end
  end
end
