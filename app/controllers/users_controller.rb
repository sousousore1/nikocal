class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @date = params[:month] ? Date.parse(params[:month] + '-1') : Date.today
    @stamps = @user.stamps.find_all do |stamp|
      stamp.target_date.mon == @date.mon
    end
  end
end
