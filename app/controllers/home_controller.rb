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
    if params[:week]
      params_week = params[:week].to_i
      @this_monday = @today - (@today.wday - 1 - params_week * 7)
      @previous_week = params_week - 1
      @next_week = params_week + 1
    else
      @this_monday = @today - (@today.wday - 1)
      @previous_week = - 1
      @next_week = 1
    end
    @display_days = DISPLAY_DAYS
    @stamp = current_user.stamps.new

    @stamps = @users.flat_map do |x|
      x.stamps
    end

    @yesterday_stamps = @stamps.find_all do |x|
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

  def monthly
    @users = User.all.sort_by do |x|
      if x.stamps.any?
        x.stamps.last.updated_at
      else
        x.created_at
      end
    end.reverse
    start_date = Date.new(Date.today.year, Date.today.month, 1)
    end_date = start_date >> 1
    end_date = end_date - 1
    @target_dates = (start_date..end_date).to_a.find_all do |target_date|
      (1..5).include? target_date.wday
    end
  end
end
