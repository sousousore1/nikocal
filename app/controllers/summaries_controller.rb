class SummariesController < ApplicationController
  before_action :authenticate_user!

  def index
    @stamp_of_year = Stamp.all.find_all do |x|
      x.target_date.year == Date.today.year
    end
    @stamp_of_year_json = convert_to_pie_json @stamp_of_year

    @stamp_of_month = Stamp.all.find_all do |x|
      x.target_date.month == Date.today.month
    end
    @stamp_of_month_json = convert_to_pie_json @stamp_of_month

    this_monday = Date.today - (Date.today.wday - 1)
    this_friday = Date.today - (Date.today.wday - 1) + 4
    @stamp_of_week = Stamp.all.find_all do |x|
      this_monday <= x.target_date and x.target_date <= this_friday
    end
    @stamp_of_week_json = convert_to_pie_json @stamp_of_week
  end

  private

  def convert_to_pie_json(stamps)
    stamps.group_by do |x|
      x.status_text
    end.map do |x, y|
     [x.to_s, y.count] 
    end.sort_by do |x, y|
      x
    end.to_json
  end
end
