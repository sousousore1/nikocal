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

    @todays_one_chance = @stamps.count do |x|
      x.target_date == @today && x.one_chance
    end

    todays_stamp_count = @stamps.count do |x|
      x.target_date == @today
    end
    average_input = 0.5
    @one_chance_percentage = round (@todays_one_chance == 0 ? 0.0 : @todays_one_chance / (1.0 * (@users.count * average_input)) * 100)
  end

  def monthly
    year = params[:year] ? params[:year].to_i : Date.today.year
    @month = params[:month] ? params[:month].to_i : Date.today.month
    @users = User.all.sort_by do |x|
      x.stamps.count
    end.reverse
    start_date = Date.new(year, @month, 1)
    end_date = start_date >> 1
    end_date = end_date - 1
    @target_dates = (start_date..end_date).to_a.find_all do |target_date|
      (1..5).include? target_date.wday
    end
  end

  :private
  def round f
    ((f + 5) / 10.0).floor * 10
  end
end
