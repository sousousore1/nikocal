class SummariesController < ApplicationController
  before_action :authenticate_user!

  def index
    # for year
    @stamp_of_year = Stamp.all.find_all do |x|
      x.target_date.year == Date.today.year
    end
    @stamp_of_year_pie = convert_to_pie_from @stamp_of_year
    @stamp_of_year_chart = convert_to_chart_from @stamp_of_year
    @stamp_of_year_chart_categories = @stamp_of_year.map do |x|
      x.target_date
    end.uniq.find_all do |target_date|
      (1..5).include? target_date.wday
    end

    # for month
    @stamp_of_month = Stamp.all.find_all do |x|
      x.target_date.month == Date.today.month
    end
    @stamp_of_month_pie = convert_to_pie_from @stamp_of_month

    # for week
    this_monday = Date.today - (Date.today.wday - 1)
    this_friday = this_monday + 4
    this_week = (this_monday..this_friday)
    @stamp_of_week = Stamp.all.find_all do |x|
      this_week.member? x.target_date
    end
    @stamp_of_week_pie = convert_to_pie_from @stamp_of_week

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

  private

  def convert_to_pie_from(stamps)
    stamps.group_by do |stamp|
      stamp.status_text
    end.map do |k, v|
     [k.to_s, v.count] 
    end.sort_by do |k, v|
      k
    end
  end

  def convert_to_chart_from(stamps)
    target_dates = stamps.map do |stamp|
      stamp.target_date
    end
    target_range = (target_dates.min..target_dates.max).find_all do |target_date|
      (1..5).include? target_date.wday
    end

    filter = -> (stamps, status) {
      target_range.map do |target_date|
        stamps.find_all do |stamp|
          stamp.target_date == target_date and
          stamp.status == status
        end
      end.map do |stamps|
        stamps.count
      end
    }

    stamps1 = filter.call stamps, 1
    stamps2 = filter.call stamps, 2
    stamps3 = filter.call stamps, 3
    [stamps1, stamps2, stamps3]
  end
end
