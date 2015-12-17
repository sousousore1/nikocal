class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:help]
  def index
    @users = User.all
    @this_day = Date.today
    @this_monday = @this_day - (@this_day.wday - 1)
    @display_days = DISPLAY_DAYS
    @stamp = current_user.stamps.new
  end
end
