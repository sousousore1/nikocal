class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @stamps = @user.stamps.find_all do |stamp|
      stamp.target_date.month == @date.month
    end
  end
end
