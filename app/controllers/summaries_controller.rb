class SummariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stamp_of_year = Stamp.all.find_all do |x|
      x.target_date.year == Date.today.year
    end
    @stamp_of_year_pie = convert_to_pie_from @stamp_of_year
    @stamp_of_year_chart = convert_to_chart_from @stamp_of_year
    @stamp_of_year_chart_categories = @stamp_of_year.map do |x|
      x.target_date
    end.uniq

    @stamp_of_month = Stamp.all.find_all do |x|
      x.target_date.month == Date.today.month
    end
    @stamp_of_month_pie = convert_to_pie_from @stamp_of_month

    this_monday = Date.today - (Date.today.wday - 1)
    this_friday = Date.today - (Date.today.wday - 1) + 4
    @stamp_of_week = Stamp.all.find_all do |x|
      this_monday <= x.target_date and x.target_date <= this_friday
    end
    @stamp_of_week_pie = convert_to_pie_from @stamp_of_week
  end

  private

  def convert_to_pie_from(stamps)
    stamps.group_by do |x|
      x.status_text
    end.map do |x, y|
     [x.to_s, y.count] 
    end.sort_by do |x, y|
      x
    end
  end

  def convert_to_chart_from(stamps)
    range = stamps.map do |x|
      x.target_date
    end
    from = range.min
    to = range.max

    stamps1 = (from..to).map do |x|
      stamps.find_all do |y|
        y.target_date == x and y.status == 1
      end
    end.map do |x|
      x.count
    end
    stamps2 = (from..to).map do |x|
      stamps.find_all do |y|
        y.target_date == x and y.status == 2
      end
    end.map do |x|
      x.count
    end
    stamps3 = (from..to).map do |x|
      stamps.find_all do |y|
        y.target_date == x and y.status == 3
      end
    end.map do |x|
      x.count
    end
    [stamps1, stamps2, stamps3]
  end
end
